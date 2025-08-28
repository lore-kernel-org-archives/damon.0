Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E0823F405;
	Thu, 28 Aug 2025 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756351340; cv=none; b=MmJbHBl/4DpV7DRCBnaAAMPYKasAUV1UiVuSISLUL8DKempUGXjxlyYG6OAyd7YyVT4ImCxJ0HdK+C+myliZ4SJIhs4XSGys8QfobG9hqtlEm8/TzEGncOLiUbGc5NibDxuMBm2/EX95gsVByFR3K59fhCxQJxBmdSqXeh6MD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756351340; c=relaxed/simple;
	bh=XhDmvGrWM5u3/B+0t0XrZpoX53G2CFMHZKZ6r8ZGMTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b5FjmkIv4IeCbmOibCmammgyEDLvr1A+LnrCaS5+1HRStU1FWSkOHTU6iXHvtJVt7a1MkbtplcpXzjY6lssFCOMPYD4iie7rxGekRVPwcwhuFUlkP9mkeraKKNJ7BYfPfDXXGGvKhKPLOluZIcKC9CObhX+JN5uK+CWhiDJY0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZHglEs3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZHglEs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B7CC4CEEB;
	Thu, 28 Aug 2025 03:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756351339;
	bh=XhDmvGrWM5u3/B+0t0XrZpoX53G2CFMHZKZ6r8ZGMTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZHglEs3FJELZvP/pdWLwB5gUcEpjTr9V7vT4Hk+hpdrUQVxWU7487LCN8ASr9xrm
	 qZdIVlmUQQFR038mZpyXf0anTeKi8VWLnAADaYZYr7YcM9VDoCBPP/5ceUr0l0uumK
	 5aJbq05JPXVGumcYtpBmKsZ9TUVuhta0FJUmtFRvuezNDpzL/u0CqbUnE1R7Jlrofu
	 wy7VbfQsk66zGIAl46GPiBC1hp078w3WfesOuVby3NvPurSZuU4a53UPdConjEgwp1
	 dxFgsPM+FyMSXZ8KfBEoKNXi2VKOWniGfUVxwvvcSJHXOcM7ydvmCxl743i5ZQwLw9
	 MaMQ9KYEz0Z3g==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com,
	kernel-team@meta.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 03/11] mm/damon/paddr: support addr_unit for DAMOS_PAGEOUT
Date: Wed, 27 Aug 2025 20:22:17 -0700
Message-Id: <20250828032217.6458-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2c0477d5-217e-40fa-aa26-1dde19280779@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 28 Aug 2025 09:38:34 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

[...]
> Great! I believe this approach is better. This modification is more generic
> and eliminates the need to deal with those messy configs.
> 
> I have also re-validated based on this change, and it is working correctly.

Thank you for reviewing the code and further testing it!  I will post v3 with
this fix soon, probably tomorrow morning in Pacific Time, unless someone make
a different opinion or I find something I missed by then.


Thanks,
SJ

[...]
