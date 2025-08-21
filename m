Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBB3090D4;
	Thu, 21 Aug 2025 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797087; cv=none; b=Rwku63dGEUNoeG4vUcf40QGK27QACiFrwLjZpyffgIS6S/JEdk4ybau2GQuZyxM01zmVftfPX3HCJbF82dIg2q7SFn1A0XDtrkenf7+BMDjQUmwT43x0Myz7tD2vjRgfh211qApo4vDk5Ba8ZHo+xpnhhM+FyGtzwe0FZqa9eQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797087; c=relaxed/simple;
	bh=zvag0ItsqVk++H/ShYx94vCt9ir2zllvDThN1dD+mBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gwmEm203NgEyEZlP0Sovg1flFKmzgYuMxZL4C1ITvTkPX5ZXyydCBRLstY6MMcjcwAdg8pcS41mwtMKj9T6NUfdZosEOLcjWVUtF7VMvcbIQNJ5J370LN4eoOV10G3Ojyi84HrIRGCH+jbXpAf9AV92N8oK900ludVVL0WSNfPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaXP/rtT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaXP/rtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50A4C4CEEB;
	Thu, 21 Aug 2025 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755797087;
	bh=zvag0ItsqVk++H/ShYx94vCt9ir2zllvDThN1dD+mBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OaXP/rtTLlvEoaQqa1Dn+8YDGCh29zSrfDZeUKHufdVMfC3FOWf2+DJ7xGtOaTJt1
	 PqgBJZLfae67EW8bEpGXCVCPIYR/s5wowwRc7W0KFusJ6U0C27fAyV5J0dnqxplY/L
	 7d2Wu0yUfw+tN+YtxgVRKUJqxB8uRIKgQD3FWzsc5mIrli5QnFFY9LlO6Wnr9i0BLp
	 yvsRtkbP0aj0NHNkpvIM4XVRd9JwDqHkNs1aURCbwNzyiC5ABeTPvlwhjaTTLZvr6g
	 qPo2Yt7sP9dqSJ6bCs02Q0nel9gzQh42RX7i0vhHaMh02pCWsBJmxGXd2LrODeDj28
	 443+eEjWdScQQ==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 10/11] Docs/ABI/damon: document addr_unit file
Date: Thu, 21 Aug 2025 10:24:44 -0700
Message-Id: <20250821172444.82455-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821105159.2503894-11-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 18:51:58 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Document addr_unit DAMON sysfs file on DAMON ABI document.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
