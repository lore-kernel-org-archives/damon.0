Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A6C35E95C
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712624; cv=none; b=Y6b0Zhqp0IoFI9htwbiglLt7jLVzVdbbAoPspyW/6w8cxuqGYcEviwk8tK5CEmMt8f2sDD2xJ+LeJLjqdvU2Mdxkh4WRMSmrkuDRdvV8M8WOHjzVQUKlrxVrKP+XUTRaVM6n2ROtQQfamu2cSdFoIVZ/BNY+yAT2q1vzxn0IZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712624; c=relaxed/simple;
	bh=0qKs90jLN4xekAxq6jZ8hij+I7GpVR5jA89NYOy51H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzk6i0B+MijVaYOL7etypTLFMg4FyUNZ8u5sgjYCO4268CSZabnA0Wzx3rMdE5Tho/lvyd67dXN6JAswVuLMCm9dRdfDg3XldCbV65a0XCyO9HPOAHxWfi2Rje23Fv2vHlOG8pLxI/hMOi8hPB7DK3vvKD3pMG6J/KIwUTvmuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg48Qz2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg48Qz2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6E81F00A3A;
	Sun,  6 Sep 2026 16:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788712622;
	bh=U3IRCdyWhy7UugjTPoEoo9I9XEPT3OZ604RZQzuTysc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dg48Qz2B+Hn1EJpwI8OYyJ9QMge61hMAI6FhY+yM7kljnP2iL5VVrve6zH9K1RUeP
	 x2/igGhfHdv+RLfn1HaQ+53eu2PnzkhZua34HW7TIBpd/llYowJfNCte8eGqFkD5cy
	 avrtuwA/7NarbcNHF8lwagOkT7HAGlnidHkgvNajyCJTf+bWwf65n3QKf3bOOTlVoa
	 FUGLTxjgOylJfnN8v0vxlcT/1lYdHMs7H+8EsMSkUhvk4mIbzQWawxxytBAUtHr7Lt
	 obpQ61R5zer1ufEhkTxmXXtnS/4V2BObtZemd4mlEIwjBRk2B892Rns6GAcisg6Cv/
	 yUIdhG2T/NmiA==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Paniakin <apanyaki@amazon.com>
Subject: Re: Roadmap for extending DAMON beyond pte-accessed bit
Date: Sun,  6 Sep 2026 09:36:55 -0700
Message-ID: <20260906163655.25985-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906074341.29976-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  6 Sep 2026 15:43:21 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> On Sat,  5 Sep 2026 10:15:36 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Therefore, I believe we can consider milestone 1 nearly done.
> > [...] 
> > So I believe it is the time to start milestone 2.
> 
> Hi SJ,
> 
> Thanks for the roadmap update.  This direction makes sense to me.
> 
> I plan to align the Arm SPE extension with the common
> damon_report_access()/data-attribute infrastructure and coordinate it with
> the AMD IBS work, rather than developing a separate interface.  I will follow
> the upcoming patches and would be happy to help review and test the common
> infrastructure and the IBS series.  I will also track the remaining work
> needed to bring the SPE support upstream.
> 
> I would also be happy to take on some related implementation work.  For my
> earlier DAMOS_SPLIT work, I am now preparing v4 with this direction in mind.
> We are designing representative workloads, collecting data, and exploring a
> few design options before deciding the exact shape of the next revision.

All sounds good, thank you Lian!


Thanks,
SJ

[...]
