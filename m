Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43FF261B91;
	Thu, 21 Aug 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796332; cv=none; b=MVp2cvr0wCpJF9dR/VoOOkEBPInzr5RkuZ6bSXPGME+EfIJV7+92fBDlXS5VooqS2PTkAgpxmCv2ov7GZeeKinO0+PIZiMnyQmJXJD18NvHJMj2+SOB/gNjvgG3DDz7TKg/I6XWVqcW+PLX3pnL2vdUqp/ZcFAaPs67IfemOIok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796332; c=relaxed/simple;
	bh=776dOe4i9IFNCui5sdgxEUAWN2RM69Ea0yYml+XCeJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LPIO0SnV2Gj+2imZSdG7iUU0/W4xACi8io2QsfZe3aJRn56uuWqp7TeK03PINCFL1dmYWZwVWG30FJN8xN0lh52lAiYwlVRvZuGdd3NeZ7dFpCrx8dqU/+O8hB/VpHXlWdXQvGQPforiQmiJ8eSIFmkNelaf59uWzad9MZbBMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo44FYrw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo44FYrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C962C4CEEB;
	Thu, 21 Aug 2025 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796332;
	bh=776dOe4i9IFNCui5sdgxEUAWN2RM69Ea0yYml+XCeJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zo44FYrws7fSlzZa14Ed3KDfjBJU7o4Tg1IkCGu1DodBLHFqahZOYZMWXkuwE3ium
	 tP/Bdz4HaGhwgRK6TbqO67q1QczfxtbbaW4iwafNTcU7tQXf78FeEeabCYhQ/GJSSz
	 qAf4FqTKOGZaD/2SSS3Y3Jro1/LuLkEUEwF6TlKMKx6WbrrMrkf779255bCG8XRcIu
	 34LkU5DEQZDF+4HxKq01FmLA1cdNJWG2cLbUimeSnvIwqjugDk0hfVd7EBRb7Wq/lz
	 m5OjDMti9gCu6M7ct3pfMOIUdXTW55y1ab2sCVlqS8FlzRWoytrtCEWfemmn7dzgTx
	 V1fPpfcXILKMw==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 02/11] mm/damon/paddr: support addr_unit for access monitoring
Date: Thu, 21 Aug 2025 10:12:10 -0700
Message-Id: <20250821171210.79600-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821105159.2503894-3-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 18:51:50 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Add support of addr_unit paramer for access monitoing operations of
> paddr.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
