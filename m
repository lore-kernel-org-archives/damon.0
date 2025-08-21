Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B419657C9F;
	Thu, 21 Aug 2025 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796879; cv=none; b=BBGs/W3DRitQLiW4Gfy8m5gP+v8Gps2yIGwYho04aeaktAAacLAx0+0unTDURmUXUV9HwjhEyANIqc3HldEfdRhMUU20yI1nIdBNo3A5kABKGSwAWCfyM76d0oc9gi2hQ7iXW4+IiDtSkO1D7au2wulvCz9VEQ9Yt1SgJoAdh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796879; c=relaxed/simple;
	bh=E0Vi5c30Cu76scUs3f6qRf07u3YDzAxATcvA54H/SEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tlHq969V8e5r5H4gZABxjiuw0c49WKxweUv6B/VlPvQSCyOXnJcQC3cyzbCcthXjHTEWWMxkivId+INd8/7sRaofQFEAjmLN5pYbG7wzW6qLzRu6iK2XYUpHdOjMGceSVShMaSO/GdxXJayvXIdRVM2GzjhsRL84zmyL8IAxNak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWEdl3J/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWEdl3J/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF06C4CEEB;
	Thu, 21 Aug 2025 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796878;
	bh=E0Vi5c30Cu76scUs3f6qRf07u3YDzAxATcvA54H/SEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWEdl3J/4HQ/3zf7JFAOxyl3zZr5zyt+S3YX1p3Ek05mayg5h2D/s0p7KDr+elgTY
	 MFjqIetJAZzCX4IXTkazMAjfdZ259eu09S7YikFd2uo3nu4d6WOXrhlkCbsWTjfzr2
	 tN0fRHX+bSZ3BSu5exh4uKfm0UM3PymAmBAwn5IDpCZp7QczbDpYrlnn/RzQyCCut2
	 jB9woZbso6K9hC1oXV9hRSrvwjzAMWa6hNpADjkAbdJzshdVsY1ALp9qItmjg6TNvQ
	 +dpUc/58xk70M2dQiAx2fS2WqdKl50O5XuPhk57vekOnFqOyEsbpe/CdG9hH93WJxt
	 mi6+253ErSXLQ==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 07/11] mm/damon/sysfs: implement addr_unit file under context dir
Date: Thu, 21 Aug 2025 10:21:16 -0700
Message-Id: <20250821172116.82165-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821105159.2503894-8-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 18:51:55 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Only DAMON kernel API callers can use addr_unit parameter.  Implement a
> sysfs file to let DAMON sysfs ABI users use it.
> 
> Additionally, addr_unit must be set to a non-zero value.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
