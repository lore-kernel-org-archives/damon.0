Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101657;
	b=O9gL18Dc+v93cfgtaajhwo+H+uH7feXkn0wZEShdTs2EYhRuwgaoRzpiu1xG91qJFWYR
	 748XzwTWIYfSEo89bNSk28XB37H/IoAapkstefJ9Sgwb6k2xBrBayp4CseuaZbswzN7l0
	 Yw82512QERFofCD9p2BCdPtbIDjQrEEPftU40X2Li6bd/3oVEkktDxNBjvOXZOkpv2b9W
	 cuteFBZzp0gL3+ifjPqU6L0UVOh2mt/cOREJkQ1zbW81wcxkyvqjuN9xGpCgLGTnkpxR5
	 bAfza2GEVYSJO6slHJbDRnqhT+x+Nrgcjb+4oWPfMFy0ZX1foyzznsjx7oe/PwqcESA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101657;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7aM18KL7g9kFBhOsujAA1/eBDc28glRs4JMmbTTTHu8=;
	b=apPyUcoMYgjtYmWK+6j9q0vBnkoskM+NHCbtESlyOSreq3swrcY4tnJs07bad9sPK0HO
	 jqioA2EqZePih4y6mTJ3GePSPBoULwmtKx3jyUlglSZanYfpu2f9g4jjzG5Y3l6fL2O43
	 VNJtnykP25JTsm8DaKmop61z1bR/0peHlnLfXmvfe9FadeqIGdbNM0uyKhglJiI2+uePv
	 j3wCo9sSCI7+lSOF9c57o6cMBy5QHXQjl8MJPXx7Ga3YS6dLNp7AwS4KNoDrHGGhq2ax8
	 Eoqppjm3Der8FGC9TnTZO/+LwGplkTkJCmHiE+nuAhD3DFMdUWhjp4F5wS5L4jxqYtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dp0Jnkep;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42D606A324
	for <damon@lists.linux.dev>; Thu, 19 Nov 2026 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dp0Jnkep
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A711F000C6;
	Thu, 19 Nov 2026 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795101656;
	bh=7aM18KL7g9kFBhOsujAA1/eBDc28glRs4JMmbTTTHu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dp0JnkeptcPSMF4kD6ldncfTVFbWJ8cUqfmGML+1TU9k3gzMCIrkcI923XKR9x7VD
	 vAV6WmX8kgIW5/beBx3KLS8mbFZ0NQawgMCJrZ+t5ug7gnffZsVXqlYNdRKvkWsKb8
	 pEf6LfPxt7V9jfyMJpw+R+mjmSB1m0lAvGOFygx5nxEEe+6K+RYtnskCApUH2avDNV
	 4H1X29R7WTU46Y1M6UJSSnLd0tuV+PRQI6V8o5HkX7gm7ldwvkqyRYX0hOXcHcL5qa
	 vOk6U8HVOV55GHjsdudR/KUJMNvv9T7O91HS/T9RL3DTlNDzXddTno+idmn/5wjZum
	 gXTESz3lnelGQ==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: skip apply_probes() when no probes are installed
Date: Thu, 19 Nov 2026 07:20:43 -0800
Message-ID: <20261119152044.57386-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119-damon-skip-empty-probes-20261119-v1-1-ec3e81c1f26b@gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Nov 2026 19:39:24 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> While measuring vaddr monitoring overhead, I noticed that kdamond calls
> apply_probes() every sampling interval even if no probes are installed.
> The vaddr callback walks the page tables for each region's sample, and
> paddr looks up a folio and takes a reference if it can. There are no
> probe hits to count in either case.
> 
> Skip the callback when the probe list is empty. Ordinary access checks
> still run, and installed probes with zero weight are still applied.

Looks good to me.

> 
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  I will repost it soon (~1 week)
as an mm.git merge request.  So, no action from your side is needed for now.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
