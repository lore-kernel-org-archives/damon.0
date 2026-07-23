Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD11DE8BF;
	Thu, 23 Jul 2026 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766163; cv=none; b=q4F+Vsw3sbG2KxrT6rXGbrufXoQZ8uwK7bWiag0Ff9gL4bh7wfBtblJO0YOEXfqP6Ctm3v88Y7F5BiFlqh8HWjbZEdc3XjjK4mZcKjQupWovahofzvje+3i/JdvUU8t62lZLKY8Nw/T2E6KqZj5lWGGAzFcH+wGF5cdof5zIe5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766163; c=relaxed/simple;
	bh=mQTu6ltUKuBLiZFwjLoLbUoQeC8iZmbGtlfhHYpmVVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhGCnM0ymF18OUx+uQ80xfGO86OwI7m0VZnjo35c3/Bxa0k82+jbvdtAnrV8M/lp8/3UOU35Q5qhEKqsgbFvrlVtC9Vs17aryoZmknAbTNpuT/xMizP592AfJeqaSq75yzf+200iBA/B/me4T6e1Lk1UPGilipzMxZqVZAePmAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDuMU6Ck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDuMU6Ck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51341F000E9;
	Thu, 23 Jul 2026 00:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784766162;
	bh=s+EUYRbTCsafx3NRNiOhqGf1CkM1sXhNleIDSv6QIi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jDuMU6Ckhmka3jN+SkZfzLxTv5XpdG/Qio3YBcXwyikvGNSEbWITRENjrCgxVsTHr
	 qGsgyMpjal3mm8QyAzdV2dypu/cmZ5yS8kbiZ0zoRZkNEhakkccDCnoAp4PAxClCmJ
	 jn7Re2ckKUV7SIcQG2NSob9glzsVBqlltDu+nvNg4RrFs6HHNSKJSX9b8jkgjtYwYQ
	 QJ+Dlz4dBdXVYcmBKQZPeciicDxOY80tSrxnS+XYNiREArFhUTWjhfgkD2eL2qsUfG
	 9DboB8nljRaybFb19I+cG4YRUvYOUiB3oyvtdZhl2ocd5ur4RA5Ts1L7m8bcl50lCV
	 qWBfhAdivTWOw==
From: SJ Park <sj@kernel.org>
To: Hari Mishal <harimishal1@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/damon/sysfs.py: clean up sh processes used for obsolete_target test
Date: Wed, 22 Jul 2026 17:22:38 -0700
Message-ID: <20260723002239.95987-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAMmC+=BDZ6thHptTq=yGvfygUQb+0i2QeGbKXH+OFcXpnTXv1A@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 22 Jul 2026 21:15:56 +0200 Hari Mishal <harimishal1@gmail.com> wrote:
[...] 
> > We (mm community) now want to focus on making mm.git more stabilized and
> > therefore ready for the next merge window, rather than adding more changes that
> > are not really urgent.  I agree and want to help [1] that.  For the reason,
> > unless Andre pick this first, I will request adding this to mm.git only after
> > next -rc1 release.  Let me know if you think this is really urgent.
> >
> > [1] https://lore.kernel.org/20260722133829.87607-1-sj@kernel.org
> 
> Definitely don't think it's an urgent change. Anyone who is using a
> tool like damon would be able to debug this quite easily.
> Thanks for clarity, again.

Thank you for confirming, Hari!

> 
> Accidentally dropped reply all AGAIN, sorry about this. Resending to
> make sure everything is public again.

No worry, we all make mistakes and learn from those :)


Thanks,
SJ

