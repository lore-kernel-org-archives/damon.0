Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA9722CBE9;
	Sat, 21 Jun 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750527404; cv=none; b=u2eCDD92Ho+LMIzbuuKHai14ttcYfaeLRLDymeO2NciBfIS8JkZqgDIaJ01Dt8Pt+Jf7w9I9EczBq8Rd3oJVTE17PxHGQqMZyqcXYF8+11WyuqSVjtL1i7TEgQ5M8lJQW5FXNMizvv5v/DN7u37+4NRFd9m4ouBIg96MRiSVY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750527404; c=relaxed/simple;
	bh=kP4GHSR6BkGJ7Nx4/EYMAJkLntII5OjQnnxp5DI4Nb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u80ESyp+qTrkarfsZAIi+17y4xX7w9yakLn6B3afdtd+F71xy8fbwo4eRpcAOpFvJhwCtrvoXjue7wUnlMAQzVAvwdGwgMO1cZG55nd5/2NlCOovvie9ErX5qP5QFsrSdqVYITVQu4YqCHHTVD7xISsqKjdVkDZqYRqGDL51Bn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXkbCgzF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXkbCgzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423A7C4CEE7;
	Sat, 21 Jun 2025 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750527401;
	bh=kP4GHSR6BkGJ7Nx4/EYMAJkLntII5OjQnnxp5DI4Nb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iXkbCgzF4evedUkEqBvCbSeIAVJOWQ/vPKHM6PMAIFWW8oeL1/JNJXPjBZkXMtVca
	 vPTxZ0ghiSRVuDzhCIk/eRG2i4S8twOoNWVi84R7FAHLw3Z4jEukcdamiOP6AIUzTe
	 yBdXpFd8/j+DArM6IJzuddLpUOQQdrh0CqsbytiJOlmHvzqrQJQSBgxUuATpltki8+
	 Bl0H/yuNvTLETRomIQQWRLcHm0j6K+SC4ct310l3wsfQLIcfPs3+0sa0q2Ll+dULJL
	 pY0bSttskcvWB7+IOZp2rFm1/38gEkUUxkaVmkO413vAMEttlaw0Yb4X+/zBMkKfKR
	 glAoH8rzdNdAQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 0/2] mm/damon/paddr: Allow interleaving in migrate_{hot,cold} actions
Date: Sat, 21 Jun 2025 10:36:39 -0700
Message-Id: <20250621173639.35906-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620231324.99607-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 16:13:24 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 20 Jun 2025 16:47:26 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
[...]
> > That sounds good to me! Having a prototype from you for the sysfs
> > interface would certainly be helpful, but if you're busy, I can take a
> > pass at it as well.
> 
> Great.  I will try to do this by this weekend.

I just posted an RFC for this:
https://lore.kernel.org/20250621173131.23917-1-sj@kernel.org

Note that I didn't run exhaustive tests with it, so it may have silly bugs.  I
believe it could let you knwo what I'm thinking better than my cheap talks,
though ;)


Thanks,
SJ

[...]
