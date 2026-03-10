Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31D23C50A;
	Tue, 10 Mar 2026 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773105822; cv=none; b=nYFYbgEJVvbrhyLfVRn1xHD8a+qEzH3gqEpLskMJTf36Kkbv20Ng+yu28HagOUKpHdQCbJGtUcRuS6FZW8dpFntT9VRWidx04D0d0ws+nFpad5risy3md5CZoTv+qIcXrkcjSCW9jTJE9CBvboA4Ka7X/M6Ac9yCq72+TZEvKYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773105822; c=relaxed/simple;
	bh=cwIlTuT7Iv7YU8Y797JKSBFlawU41+JNFfF6H7ID13k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFhA2EM7Yq4BxwxNM9mF2a6MNPlbuUG6TULbVF+uopgdosI79wzU45zd2mSOvthiiIXxkm+MErAZKwy71FnpqP5W+ivUFJqBOJygDrXCyK5fC2QvWFUv3fYbnCzfUiOy/j2Tn6FT2y+M8WC49XYrcvElq4FXDTzDYNLbMyGYqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCTDlbbH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCTDlbbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4CBC4CEF7;
	Tue, 10 Mar 2026 01:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773105821;
	bh=cwIlTuT7Iv7YU8Y797JKSBFlawU41+JNFfF6H7ID13k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TCTDlbbHF0GN/9s1D9xIEdiF2JqM2ixKMpilvk3PVCNUBTuxDKsaXRAJVNLnry/jl
	 YqgocIFDTKyEuKTmOwImTm5s/bQ4MlLP9SE0qAAmW1CuMx2ufOKD8po2qQ6JXSI2WS
	 f62Ga4KOmewgu8yaIOKwhHSRSyS/7D6JlkXKlo4ZQ3zCgA88wqh/DotxXjVsqTxgcB
	 n1LZGLZZLoC6DIlgNBOHOz+Da39FrYdmSDqGCgtE8GZplvltcdqLVNbSAI8+6ts7yc
	 pNdNU+OiQo7fBqA55Tc+/qD4P8moEshxNd+LBxWLhfMtK4ZO6qsZZUeVFagSKokOL/
	 DYPk9sgP/xgEw==
From: SeongJae Park <sj@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	damon@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/6] mm/damon/core: introduce struct damon_access_report
Date: Mon,  9 Mar 2026 18:23:27 -0700
Message-ID: <20260310012329.93272-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAP-5=fUPWNzFvsA0T3xJdGa1uQ2QgnZyphWys6AeFZNE54WXLQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 9 Mar 2026 08:19:53 -0700 Ian Rogers <irogers@google.com> wrote:

> On Sun, Mar 8, 2026 at 6:00 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
> >
> > The struct damon_access_report is borrowed from SeongJae Park's
> > DAMON extension project [1].
> >
> > [1] https://lore.kernel.org/linux-mm/20251208062943.68824-6-sj@kernel.org/T/
> > ---
> >  include/linux/damon.h | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 49d2983af4a8..5f2870ae02ba 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -110,6 +110,30 @@ struct damon_target {
> >         bool obsolete;
> >  };
> >
> > +/**
> > + * struct damon_access_report - Represent single acces report information.
> 
> nit: typo s/acces/access/
> 
> > + * @paddr:             Start physical address of the accessed address range.
> > + * @vaddr:             Start virtual address of the accessed address range.
> > + * @size:              The size of the accessed address range.
> > + * @cpu:               The id of the CPU that made the access.
> > + * @tid:               The task id of the task that made the access.
> > + * @is_write:          Whether the access is write.
> > + *
> > + * Any DAMON API callers that notified access events can report the information
> > + * to DAMON using damon_report_access().  This struct contains the reporting
> > + * infomration.  Refer to damon_report_access() for more details.
> 
> nit: typo s/infomration/information/

As Akinobu kindly commented above, this change is borrowed from my tree, and
these typos also came from there. Thank you for catching these, Ian!  I fixed
these in my tree.


Thanks,
SJ

[...]
