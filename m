Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411FC20B80B;
	Fri, 27 Jun 2025 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055231; cv=none; b=aeULsdKDNfJ8j1XEtCT5ZszvImxtmIrk8ml83iOoN/3/UKdXpQwLuYK97S4UuTizWmIAIIVLx8WUKt3DAoJPRCAvViaDTZX0geakvRcOCO4NgLX7rffUzcm3j5+M1ZjGFNXB5xqUR2xCavAjsEhpJTDndKwH8Et/r12FLibBZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055231; c=relaxed/simple;
	bh=cLh51Nsh/EO5zqZiVH5NCtO8ZnknKTFyQdCvxFnusyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NnSEDEd6fdvlAqwsfdT4xk5/uSPAHgIaE2Z86YNuRyDY2D+yf2jgmhc1FKZObyopckRCzRsgs4fGD4NbjvXbJfyLMoKdoP1vpjf2i/3U3T6be23vEHDIbg1cTVw4HMiNUog/RsPmVQ0ABKjCikVLtmf+tM4BQhCA1L0PANcOokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTEDtLx4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTEDtLx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874FBC4CEE3;
	Fri, 27 Jun 2025 20:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751055230;
	bh=cLh51Nsh/EO5zqZiVH5NCtO8ZnknKTFyQdCvxFnusyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTEDtLx4bYqToY4UpwyOY84uaqD98k05ByRTYs8Lv5c6hMWxj9bFU8KzMbIhOl3YT
	 Lmd9mcp3RbT1svEC3sIkrjHeSPVXENjLk07t/zN7aaMCVGH9HO8c8qZD7K984ZfbP6
	 COWarnWsPU5Qa6DINvxgrUJ66V92TGmqfJIf8c7o9FMCT5nSHQTZ615o/UVlZuPpP1
	 ZPpjbVC+jrCuPV0W3meOiikoVKJ58Pf+yyPo2CT5h+U8czASSC7dnXYVDVAmoeNOps
	 AnUj4GQpOyFAZWnGOKCkTpj9Jnn1SLt941ZIdkygOLSrnLc2US2uzMLGdh9P5/jo8X
	 VB2DXBwWWwAhw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH mm-unstable] mm/damon/sysfs-schemes: make damos_sysfs_action_names static
Date: Fri, 27 Jun 2025 13:13:46 -0700
Message-Id: <20250627201346.53536-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250627162806.50589-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Jun 2025 09:28:06 -0700 SeongJae Park <sj@kernel.org> wrote:

> Commit 6812c66db976 ("mm/damon/sysfs-schemes: decouple from
> damos_action") in mm-unstable is defining damos_sysfs_action_names as
> non-static, though it is being used only inside sysfs-schemes.c file.
> Make it static.
> 
> Fixes: 6812c66db976 ("mm/damon/sysfs-schemes: decouple from damos_action") # mm-unstable
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506271655.b8yfEZIT-lkp@intel.com/
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

I forgot noting this patch to the report, and Andrew thankfully made and merged
a fix[1] that is same to this one.  So this patch may be just ignored in favor
of the already merged same fix.  Noting it here just for a case of future
readers.

[1] https://lore.kernel.org/20250627125731.19f70c310cb4f315177e41e6@linux-foundation.org


Thanks,
SJ

[...]
