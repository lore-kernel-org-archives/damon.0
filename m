Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB102DE6F9;
	Thu,  3 Jul 2025 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751504625; cv=none; b=HB70KE/oGTIP8w0aSR8nKXG+3SKZR06ayvWyk4Op3UYDJbQiOI2L9brS2++98usl/4LCa3rnDWpFhb69kdszQmXa3wR3+nBjUk/19TLHlCHuQBlttxSzZrjxts3pW+w/c87Ruj5SwALkF4Y1RzzJUv+3GfuYu3ZzeQqHRt98VLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751504625; c=relaxed/simple;
	bh=5rU3ZMle3o8BvcmdUmfcJuB41QNksv+U1CSu20i78KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Me6i50C3Be4sdQIY58qai1dUBmGBtm3wRcWhEQmGprYHUbGBizQrgrKjcpzzfRo652Y5DNi6JG223YT39arCBPicakgFn/RQuQjdsyW8VFZCZ8c6Gf/uUP4wKxKKoFzEkQ0efunsADkLDym7yMvaY96h42aqRjLX2whfIqZsk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUIzwvC4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUIzwvC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95039C4CEE7;
	Thu,  3 Jul 2025 01:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751504623;
	bh=5rU3ZMle3o8BvcmdUmfcJuB41QNksv+U1CSu20i78KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sUIzwvC4gx+fSgmEfLApRTxN3V6+d2kPBXfKR/fQt6r3WjKHYXlMuJ33+IpsMYJrt
	 odB01vO2nU9BJKam8prfEWyedW8tt73z0AffeRl8UypwEisYqLsLmTUGsFvy5jq7RS
	 6hlpAfQBekNpaZNd0FHrBpr+j+R2h4grIb9bHgbCtcVcsTYhyeCjH/3ILabwBjmRVO
	 hXCAqnsDKcKOJXTRLcjQ609OLlPxeTHz9NDu0ig+OqnMxQkZEn91j617FS5GOkUV1k
	 wVG/zsMdLfmN2VYpGEUvcvoYGsXItsISFgGpvjZre/l8SxdE9halHZonVgN6pUrmQj
	 eoFN4PqbuZ6cQ==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH v3 00/13] mm/damon/vaddr: Allow interleaving in migrate_{hot,cold} actions
Date: Wed,  2 Jul 2025 18:03:41 -0700
Message-Id: <20250703010341.58007-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702201337.5780-1-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Bijan,

On Wed,  2 Jul 2025 15:13:23 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> A recent patch set automatically sets the interleave weight for each node
> according to the node's maximum bandwidth [1]. In another thread, the patch
> set's author, Joshua Hahn, wondered if/how thes weights should be changed
> if the bandwidth utilization of the system changes [2].
> 
> This patch set adds the mechanism for dynamically changing how application
> data is interleaved across nodes while leaving the policy of what the
> interleave weights should be to userspace. It does this by having the
> migrate_{hot,cold} operating schemes interleave application data according
> to the list of migration nodes and weights passed in via the DAMON sysfs
> interface. This functionality can be used to dynamically adjust how folios
> are interleaved by having a userspace process adjust those weights. If no
> specific destination nodes or weights are provided, the migrate_{hot,cold}
> actions will only migrate folios to damos->target_nid as before.
[...]
> Functionality Test
> ==================
> Below is an example of this new functionality in use to confirm that these
> patches behave as intended.
> In this example, the user starts an application, alloc_data, which
> allocates 1GB using the default memory policy (i.e. allocate to local
> memory) then sleeps. Afterwards, we start DAMON to interleave the data at a
> 1:1 ratio. Using numastat, we show that DAMON has migrated the
> application's data to match the new interleave ratio.
> For this example, I modified the userspace damo tool [8] to write to the
> migration_dest sysfs files. I plan to upstream these changes when these
> patches are merged.

Looking forward to!

[...]
> Performance Test
> ================
[...]
> Updating the interleave weights and having DAMON migrate the workload data
> according to the weights resulted in an approximarely 25% speedup.

Nice!

[...]
> Revision History
> ================
> Changes from v2 [9]:
> - Implement interleaving using vaddr instead of paddr
> - Add vaddr implementation of migrate_{hot,cold}
> - Use DAMON specific interleave weights instead of mempolicy weights

Appreciate your efforts on revisioning!

I left a few comments including simple change requests and questions as replies
to each patch.  In high level, looks good to me.

[...]
> P.S., I will be out of office Thursday until next week Tuesday, so please
> forgive any delayed responses.

No worry, please take your time and fun! :)


Thanks,
SJ

[...]
