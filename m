Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DAD15C14B
	for <damon@lists.linux.dev>; Mon, 20 Jan 2025 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737398015; cv=none; b=PuvYW/yV3w9UIGlNfM6kA7dOZz0Nh4xOJ8+kFDGzGIULFPpVrmX4kD94qV0FjQJj22JTFw3cMgFCIMIq6AQMgaBbd1xEbaGZCHi00lEFJ+T7pSZKI0mo3p2k3Kb22HwxUrRCBPLlZdV88+CkdyEb5QZxWw+cVePSWX8NRL0v1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737398015; c=relaxed/simple;
	bh=5tGSMpy9nxQRV6lpgAqhT95YniwwNPVJ25tW700gtGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jcM6N4N1Ezz80adR02pB9s/fWvnY74ayHEmrB6xO+5YBxA5DQ4MZYHcOCyXTyhf53EPKI7U2un/fY2Y8QJVDFwN+PSGDoAGNe4lSzPa7EP5KuJ2bne15iIO9hnCFCa/lOXvITX4/VPXjAr0LWv/Sh8gkuYKytiwgC8xoJBM7iOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih/gntzV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih/gntzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA79C4CEDD;
	Mon, 20 Jan 2025 18:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737398014;
	bh=5tGSMpy9nxQRV6lpgAqhT95YniwwNPVJ25tW700gtGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ih/gntzVyxcI92ke15Hx9iC61MtHnWWfhv41l9MHhsv1QmJNkamxSISz4uI9QLCI1
	 t++x7G/IBUHRqZbfCCEMdgpMVwgBHywEQhTGGRy260FwJp4zD6NDLv2TLFfGE+lqyU
	 zgMe+R5p0KHCmprsfa191tZzICp1FtHBrYieFiu6QB1mISFckTkFxaJ28rHE6Am0GS
	 eC0SwrpdPxK97WdLHkcqTfhM3D30sdBCrrIPMPk0C1419Ps196VCA52T02D7c/yzAv
	 Lw2TrCSpjKg4VC0YTVqOL/EptCSmdqT+mbkFgt0TigY1GYN2HIhjqwubefLv+hMwwL
	 QWNAfUQUbXDww==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Mon, 20 Jan 2025 10:33:30 -0800
Message-Id: <20250120183330.35625-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250120181959.2564362-2-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Jan 2025 18:19:59 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> This is to gather statistics to check if memory regions of specific
> access tempratures are backed by hugepages. This includes both THPs
> and hugetlbfs.
> This filter can help to observe and prove the effectivenes of
> different schemes for shrinking/collapsing hugepages.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> v2 -> v3:
> - expose hugepage via sysfs even if the kernel is
>   built without hugepage support. DAMON will just
>   just return 0. (SJ Park)
> 
> v1 -> v2:
> - Wrap DAMOS_FILTER_TYPE_HUGEPAGE case with
>   CONFIG_PGTABLE_HAS_HUGE_LEAVES (SJ Park)

Thank you for writing and patiently revisioning this nice patch!


Thanks,
SJ

[...]
