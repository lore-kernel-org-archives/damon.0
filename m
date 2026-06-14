Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A84171CD;
	Sun, 14 Jun 2026 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781462565; cv=none; b=uj2Czs1vpctFbl5CwdcqDmnUGt/Adqy52V0Bm4qo0UcubQuzvKQ64ku8K5usCT5A9zmbnQV2xCRAhAwGYd9DJu8rufhlXErTX+Cg3E8LjUAe9AvR7WE2yM7a+Z8DQG6ADOFdKp5Rm2Fzo3O/kI4O9zV0i3XpPwIvrPE4z73HB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781462565; c=relaxed/simple;
	bh=IZyk65wZJwMOTimxwBKGcrtF7abLkwcnQJW2XeCnRTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9ieqdu3UzkneWdCff03f2S/79FGodq5vcpgosYIPwXoI5Bo6l9Cj6MmlA5mhyqx2CocnOJzlJVd41ra22t3iwTvuqBFq7QxW1bZooY2w2UbRmFtA71ecIzxpk0JIVt9iacruh9dCVncAglJSolRsrpIqBquUPkv1MkXdZ0WlpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUzYmV54; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUzYmV54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726031F000E9;
	Sun, 14 Jun 2026 18:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781462563;
	bh=u1HPXB86dzP2pGmoGWZlLPJ7z34BGNaE6krvs2wo6FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NUzYmV54DK8spx6sxXnZZ5GoqoGRvqR4RrIG32M+vAroJTiiKzYPn9nUDsho3sh7s
	 Sbn4edXuw5AmMJB1iKLMmyfg+h4Fc2pDWYy6mzQQtZ49RoI8yQxThlMCT1AJ6ZyDgZ
	 uJPBQLi4aB0AIz8gFGNe4fsPJjH1n2w+x3vTAl55s5nL+oEVgh+5h/LqJEZyayg7Rn
	 xwJyZWqt/Z6Or3pn3r9gz0C22iQopES1f6/IgmfRKKWSw3UH/NouyTSYsosirmXRuA
	 t08DmlOJuazj3BQGTr9ABmpC+bgVi/tJtx9GqXZ3lI+FZhbE5TO3oDIaFVAfhONrvI
	 8eRKUFUjE5biw==
From: SeongJae Park <sj@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: SeongJae Park <sj@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for Jun 11 (damon)
Date: Sun, 14 Jun 2026 11:42:34 -0700
Message-ID: <20260614184235.101552-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4df95955-b255-4e5a-90c4-35db02f3111f@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Randy,

On Sun, 14 Jun 2026 10:41:05 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,
> 
> On 6/11/26 7:33 AM, Mark Brown wrote:
> > Hi all,
> > 
> > Changes since 20260610:
> > 
> 
> Please add missing kernel-doc comments:
> 
> WARNING: ../include/linux/damon.h:909 struct member 'probes' not described in 'damon_ctx'
> WARNING: ../include/linux/damon.h:909 struct member 'rnd_state' not described in 'damon_ctx'

Thank you for notifying this!

The fixes should be trivial.  I made those and queued [1,2] on damon/next tree.
DAMON patches are merged into next tree via mm.git.  And mm.git is currently
closed for non-urgent issues to focus on making things for next merge window
stabilized.  I will therefore post the fixes after the next merge window is
closed (7.2-rc1 release).

Please let me know if I'm missing something or you have any different opinion.

[1] https://git.kernel.org/sj/c/892a69e2774fcface1202dbdc2ff62e433f487fa
[2] https://git.kernel.org/sj/c/b205766e8d676b9c9e3af828e736215bc54f4690


Thanks,
SJ

[...]
