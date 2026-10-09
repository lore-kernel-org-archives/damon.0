Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D999381B01;
	Fri,  9 Oct 2026 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534120; cv=none; b=tngV7zLHiXJO8kLhiyYIwTFyfFqS5kKjFqZV3KBRaorh/ktWEZytreA/m5TsWQ8OnAd37OajP5veazTkgGzly+DlqPkw486cF3w2ncPVs4plxRjSSXbwB6reHJILwb622W3r9YDQTbR930Ney3jAjW2+NnjMFRHVWftw7ErPQ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534120; c=relaxed/simple;
	bh=szB/SBGNW9kFWhyrEQYion3EEDliHRsDezvmNfK0rVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7zL97VG7g3bgUrXhoobyF7oGA4mStSgpcx6e1pUBkTwh2pJKm0hSPJyRuM1u91KoyVsuYRFJ2hfN0z6/TbLdDwx06VvmtQO6XsRvEj/LK5x0y+52t4zuQXis75rLavxZim7C+3D7JtWY/7KXbV+A+Iev62wZvwWk06UjlCLeyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeLhcx33; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeLhcx33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C921F000FF;
	Fri,  9 Oct 2026 08:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791534119;
	bh=XR909C3Pjd+KOHrf5jL2WUTMt/jvGOVLkbFPbLw6Xoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OeLhcx33IW8mAy3QVGFv1zIRvGO0PRTJw79Sho141cXlFv4eOc5XRS2BpsQ98vgch
	 Tuwvp//eA2nS+vyzXnKO713iSPJBxx9behcXXYwaBia4Z0XT5ucnDIqiYs3NP9J4DM
	 769mLUjlyk8vgVnquToil1r3INpFAimFlw1haA7TgVRW0ffIgxrBaNsDeGxeeC3heJ
	 2DOBo5/jgfRxZhf54Cm21T4uoDgj0zoZc9H9nOvcgz3uPux5BhYtKgHvYTj5bKzcyh
	 KN/JKYUr0V0RsIQcQsIdIFCgZtmyUN7PtvU4/MWeUwSD5RKN9+WTQ0Jzk1U+4zFlin
	 0uufXWcHcfSdA==
From: SJ Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SJ Park <sj@kernel.org>,
	Suhaas Joshi <suhaas@s-joshi.in>,
	akpm@linux-foundation.org,
	aethernet65535@gmail.com,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/core: Copy only installed probe in damon_split_region_at()
Date: Fri,  9 Oct 2026 01:21:54 -0700
Message-ID: <20261009082154.42336-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202610091039.fhMXCn7d-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Suhaas,

On Fri, 9 Oct 2026 10:40:07 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Suhaas,
> 
> kernel test robot noticed the following build errors:

Could you please check if this is a real problem of your patch?


Thanks,
SJ

[...]
