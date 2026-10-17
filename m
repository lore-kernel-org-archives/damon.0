Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D473911A9;
	Sat, 17 Oct 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254602; cv=none; b=ExDFI27Z7OHoz4FRqq7fcT30+FH+AEVG2+4zHlihJynRdgWysZO7TReWJ+i4dW4Vbfd8SVxgq9p/8MX52wB+pa2ePBxV0LqoYCVuIM+4YWrR4vHRBXzWTyr8V37U+AGGb6GCWr88FmSl4BVyF1b2N2Nnol92kiwRd3RmQKxNTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254602; c=relaxed/simple;
	bh=NdPSzd4ka+nLN/DB/bzIh2jM9+rUkYsB2FWpRT5BCBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0cPpJvSNreCLd0ptdHvsYEzDIjvmpIhFaYoFRgOU+F59c/hMGxwZeAo1zUpOJ8QU+6gtui+LCDrRPZeul9GrgkvH60NmpbgdFgUNnOnmsM54UFXhp9Gvh2Jomr5oPs5R8aJAi84ag7cR/887GYPsVMExRVpZGqo0qiY9B33JCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeKmOw4J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeKmOw4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245001F000C5;
	Sat, 17 Oct 2026 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792254601;
	bh=X0DmlSRuNRCJbXtkSTjE1NDx4IN1vmXMrnRQ7uFb2H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PeKmOw4Jiki3/fJnnAJ22M5qF9oJIzt1qIMerDBuwvmo8EqZCLozJKW1Ihpmg944G
	 99/UgGyFtilWGzHziQ+CviBtvZwzdfMdEOlbNfPUkv7z8veajSn85RyxLbw/WSh/1a
	 PT7DNvFmI5IuBUg+BLAoFDvrY6v6Uy7MdOIvA2j+NnVDN5Qnl0y8ti6ZF/GYwZqpEL
	 E4sNe0SQrXbOD8A897GjW6N7g/Lcwuv1CFFnN2OZrMDbV0aytqS00JjeEN7s7e1vaf
	 B1nnGFXH5+upytKF2oEAJpyYXLmY5FK+4VtrNRkNxaQoNFonowvyo6RVd4W9hEigTy
	 QSfYTlWEGVCUA==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aveline Noir <jm5905938@gmail.com>,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: Re: [Duplicate Text] in mm/damon/ and Doc/admin-guide/mm/damon/
Date: Sat, 17 Oct 2026 09:29:53 -0700
Message-ID: <20261017162954.104148-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1061edcf257c9e625efe5f6f000013e9b2d4c650.camel@mailbox.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 17 Oct 2026 17:32:47 +0200 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Hi SJ,
> 
> there is a lot of duplicated text in these directories. Diff doesn't show
> any because in mm/damon/ the text is a multi-line comment.
> 
> ~40 Lines in lru_sort.c and lru_sort.rst,
> ~50 Lines in reclaim.c and reclaim.rst and
> a few Lines in stat.c and stat.rst.
> 
> I think it's important to decide on how to handle the duplication before
> patching.
> 
> Delete one set, keep (and fix) both or add a reference in one place to
> the other? Could sphinx do the duplication?

Let's keep and fix both for now.  We can consider deduplicating if it turns out
to be too much overhead.  I don't feel so yet.


Thanks,
SJ

[...]
