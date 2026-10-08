Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763D3A6405;
	Thu,  8 Oct 2026 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457475; cv=none; b=Oe28aKwXatqGhlYbmRA5IWeH6oRr0/cGTuZ2qMdb27uttELQyuS+ktieLGsIq0hb4oJ41rtIpdB+UXpb0lqurTTSeH9EFxbp3XVt8PxcvNprCE9qKW0l3mtEeGBtooEnousWQo7HMm+ocEs0oHiloinPnZX3B7VCKAvWoiZQVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457475; c=relaxed/simple;
	bh=BcpOAorQupwog9Z2s4WBq9fnHVDGoh+npCUPmDMNZ1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7wRpqhHhxhudxffY3VCpffbhx4kJjxVy8s4h2Jf9XmQQG3OxmhPipiYSnVnsZALR65DS4QOQ2noHXJPqqbuENn0RHF/8OsP90J7bReTiaI2pXWu4BIElcdks96l08ceoKhUacF5+Yj4GySRqR21GpGN8wQP7KGjHy5lJ38KxIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEZnvdbH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEZnvdbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C991F00893;
	Thu,  8 Oct 2026 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791457473;
	bh=zZk4kmtV+weBTEPyGq+1h+AGsdm3cag6C0y6gwefIXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QEZnvdbH8cWi1V2myGiQJ813AhiOpAdDmQC6n/b8pv/F1MgafcSVoR/2Tm6wqSsP7
	 rv8MPceG52K6US2zmU7DKngE287GQDo+bGyF1fMjdkWKxG7d+oP7ZiQKtAc7II/2I0
	 /+VyYgYAxlnBKPI8DtZWbq7ujZt/8cbV5jb5uKgyjPk7vViEyP3rmbiZfY5MI9OyHX
	 TEL8b54hqi5FzUSOCWSw9YAQJUJOWbsnUzOwOsuRVJ7PTGCm/3/1n6fk2E8/HYfY1U
	 s0pSuwM3dnC2mnneXMtZnD9qxk2zsaN3w9ax3a2+1RxoKP8T/x10pS9rilBzcNL42Q
	 +t8fRhakfdUeg==
From: SJ Park <sj@kernel.org>
To: Huang Adrian <adrianhuang0701@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	ahuang12@lenovo.com
Subject: Re: [PATCH 1/3] Docs/admin-guide/mm/damon: Fix various typos
Date: Thu,  8 Oct 2026 04:04:27 -0700
Message-ID: <20261008110429.41646-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHKZfL3z0-fVa7HhW+J5E0RdEUoR-E3wMFYmQ6C0ZQh7t1xoGQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Manuel,

On Wed, 7 Oct 2026 19:53:18 +0800 Huang Adrian <adrianhuang0701@gmail.com> wrote:

> Hi Manuel,
> 
> On Wed, Oct 7, 2026 at 6:30 PM Manuel Ebner <manuelebnerli@mailbox.org> wrote:
> >
> > Hi Adrian,
> >
> > I have read your patch and the affected files. I have found
> > a lot of issues, non in your patch.
> >
> > This got kinda big, so if you don't want add it to your series
> > let me know, then I'll make a patch on top of yours.
> 
> Since you found those typos and grammatical errors, I think you’re the
> best person to submit another patch. The credit should go to you. ;-).
> 
> Also, as SJ suggested in the previous email, please post another patch
> to fix those issues.

I agree to Adrian.  Coule you please send fixes as your patch?


Thanks,
SJ

[...]
