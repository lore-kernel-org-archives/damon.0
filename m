Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D18BF9D9;
	Thu, 11 Sep 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557209; cv=none; b=uhXRkjkBCeKAcfa+fVmPWAs35xGehMgg1Ii2oK4JCJT+DzbgsZMs6t7KDoxZZaRB9yuufjBL8SGavyc5GrdBPb/DFDEFYE3ZwxHGlN0DuFjB69uGM74ielHC7hcvGfIr7wP43QSCIPgwnAdFOG7r0hgVcySoMxFaEPmpncYM28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557209; c=relaxed/simple;
	bh=gzoQPAa+x4LUkdH2/K+iEEXp8aL1F5QGIdfpEeE8pZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uv8T/slY6jnn0mW4/OFt5rWivX/yqL9CH5kESpQHiQvdXWzZrpJ1Hxvpb62ciCzzJ8oOg9ruHJBkWHHokJMwMtr1YOTrowId5kZHtjfAFy8pdSXJw6x4C5wVIsodk7zgsNn9mc8oGB43oTeaHJq839pQaKmRcMuuG7W0KYdQ/Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8iv+T9E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8iv+T9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BACDC4CEEB;
	Thu, 11 Sep 2025 02:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757557208;
	bh=gzoQPAa+x4LUkdH2/K+iEEXp8aL1F5QGIdfpEeE8pZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8iv+T9EwQ1WOb70zKJt/vaaA3UhHacDQoOSk300InOCwIAXE7vIfRF+DZAbAO7i5
	 gVDLMyqp5LVcSXVWHf6DHb1QLeW9m8N5tth3K5/j9FaVxqYZptXkIteMUdaqeKBEMh
	 AU35TEwdK1LdXKHC7pG+0SkHc7afKQdFS7xG0fy1IGW6Yet94CBAEgCJO1F/1LyMYh
	 SQKhcTePIbDM0+PIePuWSzEPk4qekuKK+z43Gas5jxq6JeP7BszJfCrmgmpnCDfbZ0
	 nxyt1VB8YPPvmS6i5lJ3Eo5RcEr04D1qFzjrgCq4V62ylZh4y5p3svQPgtw/8Hp4gJ
	 cUe75tmGnS2CA==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 2/2] mm/damon/reclaim: support addr_unit for DAMON_RECLAIM
Date: Wed, 10 Sep 2025 19:20:05 -0700
Message-Id: <20250911022005.52673-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250910113221.1065764-3-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Sep 2025 19:32:21 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Implement a sysfs file to expose addr_unit for DAMON_RECLAIM
> users. During parameter application, use the configured
> addr_unit parameter to perform the necessary initialization.
> Similar to the core layer, prevent setting addr_unit to zero.
> 
> It is worth noting that when monitor_region_start and
> monitor_region_end are unset (i.e., 0), their values will
> later be set to biggest_system_ram. At that point, addr_unit
> may not be the default value 1. Although we could divide the
> biggest_system_ram value by addr_unit, changing addr_unit
> without setting monitor_region_start/end should be considered
> a user misoperation. And biggest_system_ram is only within
> the 0~ULONG_MAX range, system can clearly work correctly with
> addr_unit=1. Therefore, if monitor_region_start/end are unset,
> always silently reset addr_unit to 1.

Again, sounds fair to me.  Also this kind of information is helpful at
reviewing.  Thank you Quanmin :)

> 
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
