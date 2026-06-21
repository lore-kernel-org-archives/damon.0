Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93140238D52
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782073508; cv=none; b=LxvDmR6gbPO6EwJv0sfHiP17BVVCZEujq9UbgQvMxMX9ikeyVQyUY5lLmBRsqKeCDq5c07ds/iD6OX8PEvpMKEYFk7pVovX5PKqdmfonGiMaqoJFl/GzFkKM36wDK1/3laYMc2YG2wGh+Hk4Mjn2NxT/Sg/QBjJy/bQZT/AQ2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782073508; c=relaxed/simple;
	bh=NOd4JteZZo3fhjx+FB46lNLW8KlEvMqbRxfInaQHK1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpQ4Q8kYvzy0vL4wGZmBSJp/ZJOKBi/tDHDWiavQC5e26d1/YvjSedCz9ZZEA+2u1lsBxc3A6JTQbNJolWKRFN+vELGGX28GVZ54h/wbP04YUwLqermGqaWVfk25aEk9waMJVEUTGYTylGTMCpzVo4EH5uHOAn2D+xoUsH6lHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7mWVGOW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7mWVGOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBB21F000E9;
	Sun, 21 Jun 2026 20:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782073507;
	bh=myMpHoq5kbJxp9dCQJqSqk9v52Xd9t8kZelr0gJpNa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R7mWVGOWt5/FFzKl1UWRe9E4UtWNEO23/0HFZsF9xVldq8xiTjf00QTAQYuGNHe7u
	 AQGEl8lHTo2ePvxs42eaIKhiM7jPDql9XcPiFSuUSHswBmsSx3YPHteb2JqRJcXu5C
	 0HC7a9vZ9huO86ehJPQ71Mgur7Gmm4VNgngsy/H5ktTePoUyqaYgBBSW8XEB16LX6t
	 MIkCc0Bz/loYfoEfKYx43RNPC8VMp734wG7ldHsVXNdmZR4e4YgqleCpE63Bt4iQaz
	 YebA7uZ1S/gUB1Mu70WkiITyF6ukGd1nBA8pm9EeD8u257PlvXwYvqYfoAYgqHn6Wd
	 hl1hqz2YNVyow==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 08/17] mm/damon/core: remove damon_verify_reset_aggregated()
Date: Sun, 21 Jun 2026 13:24:57 -0700
Message-ID: <20260621202457.10538-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621160629.AAE441F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 21 Jun 2026 16:06:29 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Misspelling of the field name in the commit message.
> --
> 
> commit 859f6640a11f9d1e3f6d935049f590ffd710d9f9
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: remove damon_verify_reset_aggregated()
> 
> This commit removes the damon_verify_reset_aggregated() validation function
> from the core DAMON logic, as the field it checks is no longer utilized in 
> actual scenarios.
> 
> > nr_accesse_bp is no longer being used in real use cases.  Remove its
> > validation function.
> 
> [Severity: Low]
> This isn't a bug, but there is a typo in the commit message here. The field 
> name is spelled "nr_accesse_bp" instead of the correct "nr_accesses_bp".

Good finding, I will fix this in the next revision.


Thanks,
SJ

[...]
