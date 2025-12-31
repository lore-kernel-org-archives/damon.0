Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A16F7FBA2
	for <damon@lists.linux.dev>; Wed, 31 Dec 2025 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767144514; cv=none; b=VSbOmyoXxw9gKMVVhoc0h59ckx1Pxaym3qYMosiIYGe9OV5aQdYz4XABAPMB3HBgo6rixuN1wH2y3Ew7MrfpNN+uDfs7zr/bLyIRhrs3prexp7j8sfOf+RMwicBfDBWT5P9RuW9Tzkkrg5xEgw284f4FjxRFPEZGfwtVe4U6pgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767144514; c=relaxed/simple;
	bh=ieXve5YsxFahnvCXjygTnnUDVMZBIFsMEh43LtkNUPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YobfIQ8+d9bQwVhKXT8Ouy7yind+W2FaiWcOLA6Ks2ZD06KkiFjL3zkyh4MAdVdzErqdddYcdwhuoT9MHZjr6s6u6O06l8qZdxaEqXXu/zZtUKehhosZt6Hcod3Pp0xrvNCx3zXN/2fZIrh8gk9iqhTVMuECyM+qjm9TBwH5C1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eu9RvOUC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eu9RvOUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6F8C116C6;
	Wed, 31 Dec 2025 01:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767144514;
	bh=ieXve5YsxFahnvCXjygTnnUDVMZBIFsMEh43LtkNUPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eu9RvOUCRm/FRXhdQPiO3RGhghrck1gZTxKmmlBdWPsvvIQYy98ClGWMuupobsQoh
	 B65UHQAgMM1sewdGri4oW7Sw+NgRn5IfM5i31t8Ev4rIqFSfHAYM2BzOHNCDaKsw1g
	 rML1p9FNIJ+H4kJIGSKRpxpIoFDBs4pgfSbXCQjmJ42evOGIzW7c1Q9U5hwcQIIREM
	 yxsYXU9VmSDNBPbeQY0BfiAIJZQg73pqS4A+ZI6tqf3D7U4KYugo0RN6GHy5PRtKxd
	 BXtqJ9UEZZblI6A+KTVbu9Hpr6nBwQ6TMV1s2IN9FI3mDQeHJoq2xTF24O7uxo3o/I
	 I7I4l6K9K+OgQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@nate.com
Subject: Re: [PATCH] mm/damon/core: modified control->repeat loop at the kdamond_call()
Date: Tue, 30 Dec 2025 17:28:24 -0800
Message-ID: <20251231012826.75989-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251230005716.47160-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Dec 2025 16:57:15 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 30 Dec 2025 09:14:37 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> 
> > I will reflect the above in patch v2.
> > Would you like me to resend patch v2 ?
> 
> I just found my fix [1] of the bug that you reported has a race condition.  And
> to fix that, I think kdamond_call() will anyway need to be modified.  I will
> shortly send more details as a reply to the fix [1].  Can you please hold this
> refactoring until all discussions about the bug fix is done?  Sorry for your
> inconvenience.
> 
> [1] https://lore.kernel.org/20251228183105.289441-1-sj@kernel.org

I ended up sending the new version of the fix [1] without changes on
kdamond_call().  Unless you have concerns on the fix, please feel free to
proceed to v2 of this patch.  Thank you for patiently waiting.

[1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org


Thanks,
SJ

[...]
