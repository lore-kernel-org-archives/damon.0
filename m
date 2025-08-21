Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799901DFCE;
	Thu, 21 Aug 2025 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797040; cv=none; b=fcnwyKQYVgQzO2nmPLsJgX4hW6uw9Uqx9iUp0qf9S8fQ9K4yjQ3J2x344e2obUiqHNFfHE+pjcg1MH6JRntIln6Ffu22bhcyiICuTfhJjpuc8GycvPS8T38x4JegQOzWsMg8AdbwaHHz0Cq49gJqLjgN04cvjMulcOmEq/vDBT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797040; c=relaxed/simple;
	bh=N3/u8FVbXeMN+Ztt1yO2E2iROrvfabqVIFGfFt13g5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eR5dfgYwHRxvpArkCkVxYUD6y3CIOlMzqcTSYw3bcCcZ05gOHYR7Iml7LRvfvXpTaFXn6uB8xLrkgleL4W5bVjRrxs24UHTVJoX3hcnojpr1S254tiEXIgfrxqZ5IhBcx8nHOf+s8BlVo2fsj5/Z0DUkQ2v+LZIVr2pQvJ4Wip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufdCprLZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufdCprLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB20FC4CEEB;
	Thu, 21 Aug 2025 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755797040;
	bh=N3/u8FVbXeMN+Ztt1yO2E2iROrvfabqVIFGfFt13g5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufdCprLZOANSimLEJibjKHExpwhTdbfMQbiiAhkAbxW2wycu8FEba6N/aRbqZlEEj
	 8fSZhFLUGpSOk+jU6NP2VCSGeH9qnRx2+lFdSi4eSnJl0pUyY8SXVCDlkIQhUXnPdX
	 tQ03H+eShqW/Ix4LzVZt7iTHWTdIrbSvmB1pej6b+5FMaGEPPxSD6GPGoner5BQRJU
	 z9orWOvkwuBxFeA4+BNSwDcM8LhBieBHLlcBcSF7j/CE/BwcUmIVOkuDuxNqwbToru
	 n4nIpZU9i/BK4qDZpA2pbT1KXMymrmpVRpM/HbKwrOZbDwIqy1y3P9GhXM6LPR/Uzy
	 iWWXDk7VpUonQ==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 09/11] Docs/admin-guide/mm/damon/usage: document addr_unit file
Date: Thu, 21 Aug 2025 10:23:58 -0700
Message-Id: <20250821172358.82360-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821105159.2503894-10-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 18:51:57 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Document addr_unit DAMON sysfs file on DAMON usage document.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
