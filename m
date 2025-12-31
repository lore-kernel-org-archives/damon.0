Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1973A1E63
	for <damon@lists.linux.dev>; Wed, 31 Dec 2025 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767194975; cv=none; b=N7UlAb5X1NRTA81d5o8GzmjO6Btp+7pha64N/FgDwfRE5a/j0Xqiyoo9RiTG0RkERC9a33HcmdrXNpms1L5vg2HcbgxvDhvoyySHQpofSCiCaH11iUNyJ5hG6Vypo0MflW5Sf+TW7ne/j5UV4iXGO8XaASNQpAnVh/lpdVAMawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767194975; c=relaxed/simple;
	bh=Vkga7E40Aqb7h9QBR095J8e6qqtQ1jkzPSsHC7PjWCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl9LNCWAR71nelOsCpcg20o+H0HeWVqEdpO5e+lwuAa+5CkpnLg0TsXKoUyrPGkaVRDEph329GGX7ErAPUtlIfTvWJf0AIkImN6k34f8nUht+yHQlXeyj/LChgVaP4SfGxsntgdwWLB2/+ol66i/B6zpFcVQ1/ITwWi12GRYj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQlnXOpv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQlnXOpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9921EC113D0;
	Wed, 31 Dec 2025 15:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767194975;
	bh=Vkga7E40Aqb7h9QBR095J8e6qqtQ1jkzPSsHC7PjWCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQlnXOpvoPNTuysJKMrLTlKBeZF57Aryvin7lnD1RZXi8cB8oB+LtfO7d1Af6Gm5E
	 aEDvJXtnMtghcNmuG8sXhF1MdliVYo57ZxT5GlOFgkIqCP0POJsiiiVCcbof5BTnSC
	 RCYV/4O/SZ/ByiYJB8vuRYwcTTygsjXYGqtx8lbUcHBbfY+4GV5ngyU5DXpDyaIp7q
	 /J8Kz5Q6CLAPOSaG+9f0Mhuu5Bw4j27VKPs6z1Qt00dYtHSTIS2ZX/NwwF1VVVoeK8
	 EhQKFgACrAiY207JYL/6up2Z2w33/GezNGKljnJsaY7B9e7S8to4I/peXbX2Wu3QY+
	 SB+deAUhCcSlA==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@nate.com
Subject: Re: [PATCH] mm/damon/core: modified control->repeat loop at the kdamond_call()
Date: Wed, 31 Dec 2025 07:29:29 -0800
Message-ID: <20251231152931.82221-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC6RwVzujJcuosiignDEQoe038eRJHuJVLEtJ4-qP8Ot9w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 31 Dec 2025 15:23:49 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Wed, 31 Dec 2025 at 10:28, SeongJae Park <sj@kernel.org> wrote:
> >
> > On Mon, 29 Dec 2025 16:57:15 -0800 SeongJae Park <sj@kernel.org> wrote:
> >
> > > On Tue, 30 Dec 2025 09:14:37 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > > I will reflect the above in patch v2.
> > > > Would you like me to resend patch v2 ?
> > >
> > > I just found my fix [1] of the bug that you reported has a race condition.  And
> > > to fix that, I think kdamond_call() will anyway need to be modified.  I will
> > > shortly send more details as a reply to the fix [1].  Can you please hold this
> > > refactoring until all discussions about the bug fix is done?  Sorry for your
> > > inconvenience.
> > >
> > > [1] https://lore.kernel.org/20251228183105.289441-1-sj@kernel.org
> >
> > I ended up sending the new version of the fix [1] without changes on
> > kdamond_call().  Unless you have concerns on the fix, please feel free to
> > proceed to v2 of this patch.  Thank you for patiently waiting.
> >
> > [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
> 
> My patch for the kdamond_call() function further improves control->list
> to behave as a FIFO.  This also improves stability against the control->list
> collision issue encountered when damon_call() is called.
> If there are no further objections, I'll send you Patch v2.

If you want to say something about damon_call() uaf issue, let's make a
conclusion about it first, rather than mixing topics.


Thanks,
SJ

[...]
