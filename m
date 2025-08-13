Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709C2286D69;
	Wed, 13 Aug 2025 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755103019; cv=none; b=iDTXoaYB8U+gjBHofk2tkWgVIEaMGj2LqE/EdH7gDFp9JwwQz9RTmvoexi1/hIdvpAgdC3Jueuo+D233UGi5OxxQo73joUGTJxa8t6/FxYb0E3XguIk3p4A63FpRlf8XqZqYJWr7QcTqP/HagagHUX8JwouiVlr2Un8JwHHS2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755103019; c=relaxed/simple;
	bh=cMS8Hw531No/ecCjZmNrRX5GaWy0pG4vbghgfaqFcvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vC8pApN8tyS5n//Dlz5gWg81UbHQitEsDl9O9FknRb60Vk3+yTmLKTkXgOoHNmW+sd9IEowlzVMV0Q5+Q85R7yDRJbJlQP07V9DO+Hh0HLbfX25cXVJvl0NsxGqfKIMH81qR9k4ocuqDhJIy3jwpsawE82VLiktn5DXa5PXyAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqdQ51vO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqdQ51vO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC22C4CEEB;
	Wed, 13 Aug 2025 16:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755103018;
	bh=cMS8Hw531No/ecCjZmNrRX5GaWy0pG4vbghgfaqFcvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqdQ51vOVQzVtOZgfHpQ9GW6gLvBmeNIW82cKH9LWxO7iXj8+ReuaYfGOGrjpZCTg
	 p8V+8kf6aScbY7iwMar78t19reg5mgxStHYELRXZRuQDW5pVGXNNMlYY7R4b/dyMyT
	 X+TxHQUHAt1fNAdMi2wJXVfL/49DjyFHow/Z5T1UCl3jJLGO5FdZCdpIc6DZIaNJtv
	 pdBnWr8E5vNW/xKKfj43cnzFFHiiCCV/KDvA/eYc5zCbFpbtJOaiKis51thpreIwj/
	 ZWc3WnC7rONEDApukmvMDj/eCupGM3VnMKNkO6vit1NKZ6U+3dFkk/F0MK9/Q/SEam
	 GS1HPl4c2TOUw==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 11/16] mm/damon: add addr_unit for DAMON_RECLAIM and LRU_SORT
Date: Wed, 13 Aug 2025 09:36:56 -0700
Message-Id: <20250813163656.5611-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813050706.1564229-12-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 13:07:01 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> In module DAMON_RECLAIM and DAMON_LRU_SORT, the damon_ctx is
> independent of the core, necessitating dedicated addr_unit
> integration for these features.
> Additionally, if the input monitor_region_start and monitor_region_end
> are both 0 while addr_unit is set to a non-zero valuethe default
> system RAM range should be divided by addr_unit.

Do you plan to, and need to use DAMON_RECLAIM and DAMON_LRU_SORT on LPAE-ARM32
environments?  Can't you use DAMON sysfs interface instead?  If need to use the
modules, this change looks good to me in high level.  But if not, I'd like to
skip this change, and wait until someone requests it.

I'll review the code change in depth after the above question is answered.


Thanks,
SJ

[...]
