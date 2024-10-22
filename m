Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A705E18037;
	Tue, 22 Oct 2024 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620044; cv=none; b=AvY1smwdhCZTbX0Oxi6zrYyQTavwu4Pn8LCmytO9BLqcHeJx3vuB7rTLhtAetm/FpdaOX33ikZmlCFZbSGFDV7nXmG700pcVUhAy4K2KicWxp8jO46KPpqYhu5orsShw0KNSW2hwOGv2o3sLPGz+zGFKGvJdAQdCxCZXa8YsYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620044; c=relaxed/simple;
	bh=wUmPYWpDbdK0aiE7pA+ZEzsAVI50NPFCo/x/WIwyr6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tfs42dRUIuI5bUlmKSPfmoFuC7nhMuCBqQZIeUONppGiptdou8l1NDLA7aKNHMzuO7w6USCcleO9jgD9nLqy6/jf97jNUJv+xwW25vY6TF4NkuXrHnlrYpcPl9lIvFtqePx86HdkKKnHsaqvVV+CS80IbrHISAw8rszToC6fkjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz09EeT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz09EeT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18048C4CEC3;
	Tue, 22 Oct 2024 18:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729620044;
	bh=wUmPYWpDbdK0aiE7pA+ZEzsAVI50NPFCo/x/WIwyr6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bz09EeT+hgvcgQIK271BfD5uJ1styrPYjWTmI2P8q4k4EVa47oEyEuqLQvCUo4bxm
	 uNF1leVmdVRiHeXxFs07vSmWkmR4pujOkTXlSGSOzXYTVQ0RhOp8NWYW6rfcgDqJr6
	 HsR62cAMR/MlcgDo3pLajmQfDSawjwIrko3HMLLzLcu3ZwFy5PDHFCWj3pwJjrWR3o
	 Cvr0uOZNr78f+o/bmeEvyu9cC2wfUBiekB0tf0iaJJYlNrJV9X4HP6DcWhJLc02xZB
	 doSaMK1mPJEpjS8t8RpiYCrv5TFKCJvGRFnqeFam0PkMa6UjQmYKly4OXt/Wm45J93
	 rVymnhdtSC3eg==
From: SeongJae Park <sj@kernel.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	foersleo@amazon.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shakeel.butt@linux.dev,
	sieberf@amazon.com,
	yeweihua4@huawei.com
Subject: Re: [PATCH v2 1/2] mm/damon/vaddr: Fix issue in damon_va_evenly_split_region()
Date: Tue, 22 Oct 2024 11:00:41 -0700
Message-Id: <20241022180041.42411-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022083927.3592237-2-zhengyejian@huaweicloud.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 22 Oct 2024 16:39:26 +0800 Zheng Yejian <zhengyejian@huaweicloud.com> wrote:

[...]
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
> ---
> 
> v1 -> v2:
> - Move 'nr_pieces == 1' check into separate patch and update commit messages;
> - Change type of variable 'i' to be 'unsigned int';
> - Remove a puzzling comment;
> 
> v1: https://lore.kernel.org/all/20241018035304.1050135-1-zhengyejian@huaweicloud.com/

Nit.  If the patch series has a cover letter, we usually put this kind of
revision history on the cover letter.


Thanks,
SJ

[...]
