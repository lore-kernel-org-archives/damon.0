Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161EF9D9;
	Thu, 11 Sep 2025 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557145; cv=none; b=TY5rKGzsCB40D51e2YYj3IEsB5BFqFc5l8RIfBqNigqAzzLLaFe+I0VOywwCfMNQHSTnCkIgkU30IKHxufenFfwuJ8FZqecZzkDWZ8d87EFvG+ovKcAFsPANQQM8KGuiu9avWFJ+G/AoNHsDuZpDmNUtxEVMQ2qlFmuVCfauoTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557145; c=relaxed/simple;
	bh=un0La9+SwXf/lwBkFinbUrxU0FAkVuoKg+izmE1/S/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=seRsqY/kd1WH6lAj8y1t9mWVRDn9rwj29eYggq+fzPF52Mu6bNbrXGGkaQ7rcA8AfIOrb8V5gcpURTJ5fEwdaZ+jylG22eNzPSYKrbA1UrwvX7PsJcMZPX7f8qk1hUMra3zarJ/K95fKNOe2VNKwqxWEPE2b1z0PWNM+HbDWWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryOsXRzF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryOsXRzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7F5C4CEEB;
	Thu, 11 Sep 2025 02:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757557144;
	bh=un0La9+SwXf/lwBkFinbUrxU0FAkVuoKg+izmE1/S/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ryOsXRzFC7QzxzVSwJtSZRfmcuSmxU4AeCDUmF7MxrC7NhTVMRq3RNu6uZmkCHamX
	 N07Dxkf7Pee8pf0mAHeIQYrc5PXQQaJfu/ovxSTRXfOSttTQIZWCodvAq+5xB2av26
	 mK3DZNMAKpypAEmxvx3zxtfIICqxGnGnLez2TTya29rvCPHjfyczmgCpVZjVSvl6+y
	 mCJDE2n1K2I5MLLz9wDfr5G0UZ9WIAHOSkn+CUo+UcmYt+FpBzeuEbOwOSQkNB5Fe/
	 QcLeFWdNhhasIVYqB6lgjDeEPtriOEkppgDZ5V7S9Japy3mJAjKs2adNoqUL2L15jB
	 hwX96H2D6pm7Q==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 1/2] mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT
Date: Wed, 10 Sep 2025 19:19:01 -0700
Message-Id: <20250911021901.52580-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250910113221.1065764-2-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Sep 2025 19:32:20 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Implement a sysfs file to expose addr_unit for DAMON_LRU_SORT
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

Sounds fair to me.

> 
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
