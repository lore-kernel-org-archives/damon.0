Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81D3A4530;
	Thu,  9 Apr 2026 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779077; cv=none; b=W+Sfx5qLrw7NYSa/Y4C7SrR4CHGBPREZQ+nF6im3/KGu0fEBvK70/Bw/6+pPV6ZkaPwKIz7dYBMH3QZFhkWzU/+biamt/nDy0l5auyMNsAtIqI3Dzucz0QwspLZsPxg//EHEotF9DHCyO1bql2/KjXHN6GmRjPRvGrQ/BquRVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779077; c=relaxed/simple;
	bh=u5R21OQ0WANX9OKWBcSz+IU+Rdbvqh+en/BD7D93X2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mX1pj9u7+FfapCcBL47WgpIKaDCOD7OYiWJfLEmMF00uXnIYqtNSu+mmVzV9MOFaeLOVvYQ6PR31cp7DmgEAjUgf3pZcD7Uzr14ceSQTWkmjW+KteA7YP6lKH6U0C7JTrVGFe93/EiNG7jHPWGYRExDen1YXdK3qtAltQlsVmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndI6wPDo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndI6wPDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2014C4CEF7;
	Thu,  9 Apr 2026 23:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775779077;
	bh=u5R21OQ0WANX9OKWBcSz+IU+Rdbvqh+en/BD7D93X2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndI6wPDop8ca4aqo7vVM2jCeHLK+Q4Tked0CWpOkKW6cCfsrezHtCEa3Pa3t5n4w5
	 iDQUmACbOmjEBUUovTtFp8BeVPSpiwsysHcc1DBt+clPH5ScAVYhwlW0Zuyr32lBvG
	 tnnfuJgOE5vE63M/Sqaq60t3zt2FMhUNPVFAlychHrfXsxDWMkRwx/CjWHSbJp7aZ/
	 YGZ7wWUzoGF8prk5DNA236AmVOsH6Y0ChH/y7tjPA67EXyCUswzaxJ4BH4PKWYetyO
	 v5dG1vZbQlAUjAokCDRbf+Ip4yXu2H88jD9lmGH5SfKdU5sHDl3hENqxR1V8rqNmfA
	 a52vv0Ercc5kg==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
Date: Thu,  9 Apr 2026 16:57:49 -0700
Message-ID: <20260409235749.77481-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260409150128.1566835-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Asier,


Thank you for continuing your effort.

On Thu, 9 Apr 2026 15:01:28 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> This patch set introces a new action:  DAMOS_COLLAPSE.
[...]
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

I added this to damon/next tree.  Since mm.git is nearly closed for non-urgent
changes at the moment, I guess Andrew will not pick this for now.  I will
repost this after mm.git seems opened again (probably after the next rc1) in
the case.


Thanks,
SJ

[...]
