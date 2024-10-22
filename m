Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A00B19E833;
	Tue, 22 Oct 2024 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620341; cv=none; b=SyYu/1emZgVbpE1xpiyG51d12p0qwazW3bBQVtJ2Qgbs3ATRIm/SIHceqtJATEvq0G9RXBoTiTqSlPxlAalJiUl+kFSCVUgPqIEV5twIoSJpKuB9eES+2F19sWhZ3Ca+RVHW9+87CDVIjzq7Jnuv1dEFSKyfjrU+HTeXD+ogCm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620341; c=relaxed/simple;
	bh=zUehIrhS/pCqKKuVZAbMSVBSECx9aP/5QCzvk/YzXBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kt2gA1nDqMonMlvTtnMqPlJY+xXZNoi7pX3bdC19uL6Im6VsjZSGftIvryOjIz+8d31h7Ux+UX5G0w0sqtJJmN8wh1oFYkDcubv1LU2ElrjrOb8YISTV8WDlp5aAqF9pOtMjRMMIX7DpvuKRYyHrsYOdf36A3sqy8B2FwvM15yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaD5Mj/3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaD5Mj/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E94C4CEC3;
	Tue, 22 Oct 2024 18:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729620341;
	bh=zUehIrhS/pCqKKuVZAbMSVBSECx9aP/5QCzvk/YzXBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CaD5Mj/3IDFq3Mqt/DTH4DEjONNSr6DIekjqWeouGJxj1lPgGogJB366pnjEFY4PT
	 Ph5BViCvFEWPyzybHOsMLUQBQzAvgvMK2z0uj6WI+QKXsqulE0n9jOhZxRCvzRY15n
	 a6nDyAoOenixW4u7V6vlygXeTNfaZLZMPQKKZDCcZK/jamVcu0cRQkXb7Qnx2hEANJ
	 L1yaulqEBQkz2C+PEg1nO7EjXX7LOliTGGRYXvJMjFXyFIWK6kESBBA5m2VPO1+V8i
	 CxvUxG+X+tGO25KPccbo+rXFVf4OaRTNtBJg92H1Wbnjvcg8h7WIpvhYAqVT/8iKt+
	 vIKZp36KX+5FA==
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
Subject: Re: [PATCH v2 0/2] mm/damon/vaddr: Fix issue in damon_va_evenly_split_region()
Date: Tue, 22 Oct 2024 11:05:37 -0700
Message-Id: <20241022180537.42492-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022083927.3592237-1-zhengyejian@huaweicloud.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zheng,

On Tue, 22 Oct 2024 16:39:25 +0800 Zheng Yejian <zhengyejian@huaweicloud.com> wrote:

[...]
> To fix it, count for each piece split and make sure no more than
> 'nr_pieces'. In addition, add above case into damon_test_split_evenly().
> 
> And add 'nr_piece == 1' check in damon_va_evenly_split_region()
> for better code readability and add a corresponding kunit testcase.
> 
> Zheng Yejian (2):
>   mm/damon/vaddr: Fix issue in damon_va_evenly_split_region()
>   mm/damon/vaddr: Check 'nr_piece == 1' case in
>     damon_va_evenly_split_region()
> 
>  mm/damon/tests/vaddr-kunit.h | 2 ++
>  mm/damon/vaddr.c             | 7 +++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

Thank you for addressing my comments and posting this new patch series.  I
added my Reviewed-by: tags with some trivial comments to the patches.

Btw, at least on DAMON mailing list, we usually post new revisions as new
threads, rather than as a reply to the previous revision.  If you want to make
sure involved people aware of the new series, you can send the lore link for
the new series as a reply to the previous revision.


Thanks,
SJ
