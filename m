Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4163222370A;
	Wed, 27 Aug 2025 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315719; cv=none; b=gpo73n/+W3103PENHbCR4L8D72xWrzY/i5s6Qltlk2fMOcvDzgKDEW84ck+kug29yelLk9DRu9/DuyebQVHY0//yKahanxWXCSBrqq+vryPg+JH7XDlvHjWjGZTWMmOtW4Hht1P8YsOLlr1cyFQjifh5GT5r23tD6THPFWfN4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315719; c=relaxed/simple;
	bh=Ihd/WN/NFD7DgbyYCHyUYrG3OoCqvMMxeCfn7+DAdf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XT8pOERMO9+jJcCsuGpCG9QuJHkCdLNeJ/OjpsOpPcvWofm+FfoV6UNyqTz/CongQSpTX9FiiIP1aQi8ciljQLWGbkXIYlC5ziu7qGaGInPM6la1jxu8gsdNjjHjF+PmFY5oy2clhKtcLt9jKNf0L+9u+pM+SWPAVWAB8OEyv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2GEqtHi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2GEqtHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95F9C4CEEB;
	Wed, 27 Aug 2025 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756315718;
	bh=Ihd/WN/NFD7DgbyYCHyUYrG3OoCqvMMxeCfn7+DAdf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2GEqtHi7T9vJRjyVbY5sSlB8/fdDmk5i180Zhsei6CtJ5GkoP000/FREiZhYHZ/b
	 1iV3oDiCAWSYXmfeU1VWMhYiSuGwZsGjq5oDBQgn0U6mwLLftOAKyGZolycNZVCpZQ
	 kHoIl53CBR3/NI4yN0MpPK1TvnMrk9E1se3TAtRtLuTPvs10k91+RKRbxS0aMGilg1
	 7GIEPn8IH4WOEEL82bA+QNRjpbyD1BJYZk246azDiMALKQJCRzUCcxvYXFjEjTk6Mj
	 /6A6L3ggBjRci99/laP+nhya7VXnudwDD3fgnovqIEBZBebF5J/5pI+5DgIcE8U92K
	 Fq1Ax1RM7lw6w==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 0/2] mm/damon: void divide-by-zero in DAMON module's parameters application
Date: Wed, 27 Aug 2025 10:28:36 -0700
Message-Id: <20250827172836.105335-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250827115858.1186261-1-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A trivial typo on the subject: "s/void/avoid/".  Andrew, could you please fix
that when you pick this in mm tree?  Let us know if we can help.


Thanks,
SJ

[...]
