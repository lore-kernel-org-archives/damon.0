Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D11DFCE;
	Thu, 21 Aug 2025 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796612; cv=none; b=oQZJyHtQGRDFEOwrkoUwO7wc0tSoKLFK03BI262a+hCU4FoXL6oNZREIU+39a+bAOy8WW1xuYiMBuQflEq74VeFGims4++4X/FCdLkxDo4J7MsManKRCjFMX8H14uyWbuZY/PdAi0rFe/NmvnQrto5y+iBfAcuOXZZZi5OEciB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796612; c=relaxed/simple;
	bh=3T5rhpFWpP7D0v9Okb1ShoQaiWCVpNjwESTpoSd1OYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G+/cvmY9wEV2/JSwFLUjErXvt87V4aL/clgM1LiyCeeHUMpQFuqcZArSJWS5j1HK3MJz0lZ8pUwrQEc0KLws6OFTix62D+RajTjgezYQ4PlBMYMJqUgtqPRZrCx+52JOzVslcf2t7QKH3QaIk3nmJWlhwFGfehjM0rxu9mkMeNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbcc+nuU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbcc+nuU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A45C4CEEB;
	Thu, 21 Aug 2025 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796611;
	bh=3T5rhpFWpP7D0v9Okb1ShoQaiWCVpNjwESTpoSd1OYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbcc+nuUOlC2C89O9MlccwmYw4h92fJxE9CwNdYca1iujvbhoITJVWJqK7zyxaiQ4
	 PlXlQzvhIBRepm0Znw2JcPZdpfzrRX7LAj07CvJ6mYfMplMdJ2YXHxnGx+PSYAhxxP
	 3qRumda8vnp52O3rlD1z+X5ifU3okfll4RsNR/8V3AvpQTbYRNE/WLoAFRnFMdx6oa
	 QWrtPG4YJ5Bbv/a4VWBfv9Tm+x8msW2r2rxkB1XjVrNtQ6aFZyEVmmkR2Yrj+nDmnt
	 N8riExVTzAZRzEP6NEXzdB8hzMtNtb9p4re4qV94bD7VyUqLBl51A/huYNLmGFc80k
	 2QDezaFIUORhw==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 04/11] mm/damon/paddr: support addr_unit for DAMOS_LRU_[DE]PRIO
Date: Thu, 21 Aug 2025 10:16:49 -0700
Message-Id: <20250821171649.81870-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821105159.2503894-5-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 18:51:52 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Add support of addr_unit for DAMOS_LRU_PRIO and DAMOS_LRU_DEPRIO action
> handling from the DAMOS operation implementation for the physical
> address space.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
