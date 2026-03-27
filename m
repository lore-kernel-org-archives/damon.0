Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A23F1672
	for <damon@lists.linux.dev>; Fri, 27 Mar 2026 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620893; cv=none; b=fWVeYONh53DvGj71RNVq7RAY4l3FmxWvP+XikWzsaZablA9r5BSBrzbMm77/AowQbiaepTLUqnTMzKbn0c4McESobodNfVCowST7Je/0wXKTEhu/Kq/GWHhcrsE1zJJOgOy49UnAsWnEKlfsmf09kYcd2jnMcVTEwJUQ246s/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620893; c=relaxed/simple;
	bh=yXQlyWWnYNtbPdCh0r4vV5036zoOZh+s+XBcJkWFfmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgc0Cqg/bc9w/mLgxm1XdwzUuaA9NQKME/NbGTt5xZHcQatwJYPSV4J1prUPKUWzgtBf1E71cVPFaJUGQGbY5MPD3fnIsuF9jgj5CXrMOboPpDttuPqcf4BDG9wFQpFki+2zLaj4e0ehaB5koRh/I2Nf7AlwzuZhvEg49GWUejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma3mjiH6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma3mjiH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89550C2BC87;
	Fri, 27 Mar 2026 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774620892;
	bh=yXQlyWWnYNtbPdCh0r4vV5036zoOZh+s+XBcJkWFfmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ma3mjiH61nNEDh7izYui/7QrjOoglBmcXne6eWRWUIOBZbe9IXEBoxr5zSTBqD38/
	 cVcljtJIDfSNx6eWcpo4cEr+GQZWgC/F4nvDySDRmO74Cy/aNG2JSQqgBGPkO91vEC
	 bkpaVZ79YQMRunRGZn67AN2xLyVdrg3YT77DcCn7G4gecRK6rMbGl3mFF2K1Nl3T5P
	 jPAwbKOf1tx8Pz2/HOlhirMDv1ZU2sbMv3ZVD4c2w9c7+V44BioJ/r4bALZ+1CT9zt
	 DM6Lo9X15WqpBJX4jNWXva4efUd62euN7TiAhsgeXXFJb7dg8OG3vq2h17fXvcNfb7
	 c67rM4czVINnw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Fri, 27 Mar 2026 07:14:49 -0700
Message-ID: <20260327141450.4345-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327062627.66426-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Liew,


Unfortunately I'm bit confused about this patch.  Please answer below
questions.

On Fri, 27 Mar 2026 14:26:27 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> The 'addr_unit' must be a power of 2 for correct address alignment
> calculations.

It is required to be a power of 2 only if it is smaller than PAGE_SIZE.  Refer
to commit d8fe5d2a3379 ("Docs/mm/damon/design: document the power-of-two
limitation for addr_unit") for more details.

> Previously,

Can we make the timing more explicitly?  I'm confusing when is the time you are
mentioning, since a behavioral change was made recently, by commit c80f46ac228b
("mm/damon/core: disallow non-power of two min_region_sz").

> writing a non-power-of-2 value
> (e.g., addr_unit=3) would be accepted by the sysfs store callback, but
> cause kdamond to exit unexpectedly during parameter application, failing
> silently without returning an error to userspace.

I'm being more confused.  DAMON_SYSFS handles commits synchronously, and return
error to user space when it failed, iirc.  Am I missing something?

> 
> Solution
> ========
> Add an is_power_of_2() check in damon_commit_ctx() to reject invalid
> inputs immediately with -EINVAL. 

If invalid addr_unit already makes damon_commit_ctx() fails and therefore
kdamond exit, why we need more check?

> 
> When damon_commit_ctx() fails, the kdamond thread terminates as
> designed.

Again, I don't get it...


Thanks,
SJ

[...]
