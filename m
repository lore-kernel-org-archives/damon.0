Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA01F461D
	for <damon@lists.linux.dev>; Fri, 11 Apr 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389414; cv=none; b=La/JHQtlZVGisX2xZC1fgOc2Do3PQtX0JuBwV7oJ8tilb6mPZl5SiJrrVvT/axRziFjaeEc5/ZPHPt7odYGo7TpLKh1ENwCEDbqtUayoUl6tpFXIbbmHVkizf5csGIVYA3ftj+xkNOeJCxfbBaif1zZhMXxGS76lHeZ14rFU3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389414; c=relaxed/simple;
	bh=2+7NXYw+el0uTN3IokxudZ1r60YCF6RQ147vdrfK0tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aSZZippGvOJPpim7aCWY1oZW6A+2V2F96k+69LWMhZwAoXYS0AFbGe4DDGGsdV4f7/OvsLfaplmcblJHdjCwYDBGOdS3VolWLWc3CokgQbHouUQlc1TJmIquVq+niNW7TXyDuNz5Ui7RALHApQfYPAMBunb3ilORHXPF8q7Zskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXQdVAJK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXQdVAJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5290DC4CEE2;
	Fri, 11 Apr 2025 16:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744389413;
	bh=2+7NXYw+el0uTN3IokxudZ1r60YCF6RQ147vdrfK0tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXQdVAJKwnWqxN8RYM1+pvzPfp7EhMcu52HlzBN5EUy7tbkBFC2TmwYVPdRISMPBx
	 FrbhXigVy0cAdbwYqjT5VNU3C0LkY0f+GexsuR4E5ZL+po6SGoFfGdjnkelhZBRkJS
	 N76Enp+psXP4k0dEF95Wmitkf4ty6bg68/GImPn3u+H8rR1voWuwKApL3XlMbYQucQ
	 dJRUEFZtWO3vMMTsdgxLcogcZRynXtwlQ4nG36zWDUsrgrGvIrCzsyUB+fA6RGkJh9
	 k4cG052qbYKXGtOfXWsGReccc4dK8iMGZl4k+0et+TVGCMx2udisuUXDegsfgM3Ddc
	 84TjzYqCccWVw==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] samples/damon/prcl: Fix a comment typo
Date: Fri, 11 Apr 2025 09:36:50 -0700
Message-Id: <20250411163650.65152-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411073800.1444481-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Apr 2025 15:38:00 +0800 Enze Li <lienze@kylinos.cn> wrote:

> This patch just fixes a typo in the comment.
> 
> s/regiosn/regions

Nice finding, thank you for fixing this!

> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
