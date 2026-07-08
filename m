Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34CE3BCD3E;
	Wed,  8 Jul 2026 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520277; cv=none; b=mFaclz670XODjfwnugzThsZWMwmNdnb9V+Pwxmd6tWU9x5we5fYni4+HezzxM/fNy8ieU/cYe/JLMPqQRiK/l0ar3dwDFbgnoMvV47V/38deyGQjGi7uhZmcfAofnO/3xJgMhSN91EGnceSmRzLMnwjxN4NfwRVR7fT5lnvbJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520277; c=relaxed/simple;
	bh=DcbvsevGlgHuuGesg/Qv4CgypHWo1DgzHp5vEmSW740=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htAno9n/RLPf4FpSVyX6ZhxW2fbzZpD5HpK6sz7HgsJdEkSx7pbh+6S130qhbQMGquYehjqI3p6prYTiy48Ym51sHqqMX8emWB5tXrqrMHNH23X4YKJy59zoj8nLBaHE3wyPpPpc4p8EXEStxgflElqyvaN1kEUDwqeBp2RO0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de04IjG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de04IjG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3941F000E9;
	Wed,  8 Jul 2026 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520276;
	bh=1OP6bc8DQ9DDDlz+P8xeYExBeg/4G+KzWHPg6szTAAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=de04IjG4Xx46+ArvvwANYil2mUNeiRFbbhuKTp4TBhPk4HKRD5JCrXiqkrmykskzl
	 hBpLKalv1o6WS4fBC7uGI0V7jdsNnUJQKqEZ3XJvUyvK47stsjk7XifPP/QR+SnSSZ
	 +19nQs4SInhSGSO744AHWnfbPH69nXSHIj/hrtkOCWkAmwN8jYdjSJ0t+I3S/VQCdz
	 rFhTiuYU0RqXrJZSQlk8aIfX2Xg46OsDDOoVLNLGKepQ93NVRQXxK/etVIUFxQOr2L
	 v2Ea69VvIAtYSmMl42SfN/NGN9OP9nxps2Iu+1uM3XI0S7aViKvItCEuT7/jMJsUX7
	 uA2OV9E2IBGQA==
From: SJ Park <sj@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: fix tried_regions setup failure cleanup
Date: Wed,  8 Jul 2026 07:17:46 -0700
Message-ID: <20260708141747.123596-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708080107.727043-1-lgs201920130244@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Guangshuo,

On Wed,  8 Jul 2026 16:01:07 +0800 Guangshuo Li <lgs201920130244@gmail.com> wrote:

> damon_sysfs_scheme_add_dirs() sets up the tried_regions directory after
> the stats directory has already been created.
> 
> If damon_sysfs_scheme_set_tried_regions() fails, scheme->tried_regions
> has not been assigned. The error path nevertheless jumps to
> put_tried_regions_out and dereferences scheme->tried_regions while
> trying to put its kobject.
> 
> This can dereference uninitialized memory because struct
> damon_sysfs_scheme is allocated with kmalloc-style allocation and
> scheme->tried_regions is only assigned after tried_regions setup
> succeeds.
> 
> On tried_regions setup failure, start cleanup from the last successfully
> created directory, stats, instead of trying to put tried_regions.

Thank you for this patch!  However, it seems a same fix is already merged into
the mainline as commit 05ea83ee88ca ("mm/damon/sysfs-schemes: put stats for
scheme_add_dirs() internal error").

So, unfortunately we will not be able to merge this patch.


Thanks,
SJ

[...]
