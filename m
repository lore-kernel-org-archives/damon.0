Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795889082;
	b=Yoe1pOweXhYudCftJpf3dx1I5ATcJdrZtYa+DTyhqDJLdXhO2B5NCfsm4P3LVc9W/N2U
	 kUT3ZuoKXcykpv2S51T8KZWZGSI8dXLqoFYNdQxgpfhEqM5j5K4WrIm20b+nI7YvShfUw
	 eklY+tuYwzzOaMmY9nH2kT8E9d5urqnsGGzHEpAKeaUkO2Et+SXNPp1w0toHFbd731hLz
	 uDigcfsuhDHEwCJKKiWJMJOu7WvWr4MV3MAPzo7m7D6gA0mGBsWYlDpvHvqWoILKKEdE3
	 S1LJteyaDndqO8nvql52nJvUq7/dprUvYZ7S8ASwRjwoqvY+9yyA6aO5CU8LDLdeEeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795889082;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JlxDhLKhtrIT3khQfBzmXV4SytzON7ZBSCrq9E1rsrg=;
	b=jiZca+JpXZVhdxnh2/QV50XLZPLEJls4ygTOpDaPsOCRWVMI6jN3Q6eoGa3gxfDUsQwr
	 b953ud8pqGgX9qsvEwkhrPwcUNK91pfHET46AWGb4/sFxu7fQGd1ZtUl4daqpeRJfaORH
	 kyrat8k1wPcIVDJW1CpfuVxmLIYfAO3l5uu0CIJz7FDIPzf3Iw5dWVKiFtT/ZKd5PoiAy
	 vRxeoYwYGJAM+/4OP99TY9jAP5wBH1vrOR5quD+D7M6R9eqFWHCWj2v3KHgBAEP5NtEw0
	 UMt1UAkmUOCLbesY75KPeorExClLHjxIOIdzIk/WKZLM2TZ8+he+j/uFPl0XJSenvdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVdRX15g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5B9606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVdRX15g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA401F000C1;
	Sat, 28 Nov 2026 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795889081;
	bh=JlxDhLKhtrIT3khQfBzmXV4SytzON7ZBSCrq9E1rsrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NVdRX15gvYIlsCPbthbxgUaXqWZUbcu1XNKtW/m1m19T+hQb87QWeqQ4SPasN8/QF
	 RjO8MoM5PemRP5w3NC51KA2PMByM0SIABSewprdh9Wm0SYPtJlJstFjk4dRzDHnALu
	 C+UeBscoCx//6nYru3nykeYhHNWwJKMDZNtH+tdDsyiHWFRp//FrLtbXGBl4GHK/Z0
	 VNhMJx+sSry6kdvWPBOIJLW2Bfq/7cDkXdS41xLRg4N5NpFNHPV09rvzwJiIusoqi6
	 /BGCW6gNxAJ9OheY96jDHW0/GyznoKXCpzi4lP7NX5MZ9TWTjORn167abs4pGwCVzH
	 1EOUv/31nVa5A==
From: SJ Park <sj@kernel.org>
To: Enze Li <enze.li@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: Re: [PATCH v2 20/27] mm/damon/api: introduce user_report report type
Date: Sat, 28 Nov 2026 10:04:33 -0800
Message-ID: <20261128180434.168990-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <821ded57-8755-43d0-b35d-88296a6a56d2@linux.dev>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Enze,

On Sat, 28 Nov 2026 23:20:52 +0800 Enze Li <enze.li@linux.dev> wrote:

> Hi SJ,
> 
> Small question on this one, mostly out of curiosity.
> 
> On 2026/11/24 23:36, SJ Park wrote:
> > Users could know some data attribute information and willing to provide
> > that to DAMON.  Introduce a new damon_report_type,
> > DAMON_REPORT_TYPE_USER_REPORT, for such user-provided reports.
> > 
> > Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> > Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> > Signed-off-by: SJ Park <sj@kernel.org>
> > ---
> >  include/linux/damon.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 38efa41b3d1ab..45c82f536da59 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -759,9 +759,11 @@ struct damon_intervals_goal {
> >  
> >  /**
> >   * enum damon_report_type - Type of &struct damon_report.
> > + *
> > + * @DAMON_REPORT_TYPE_USER_REPORT:	User-generated report.
> >   */
> >  enum damon_report_type {
> > -	NR_DAMON_REPORT_TYPES,
> > +	DAMON_REPORT_TYPE_USER_REPORT,
> >  };
> 
> Here NR_DAMON_REPORT_TYPES is replaced by the real member instead of
> being kept at the end as a counter.  A couple of other DAMON enums do
> keep one, e.g. NR_DAMON_OPS and NR_DAMON_SYSFS_CMDS.
> 
> Then again, quite a few DAMON enums like damos_action and damos_filter_type
> don't have it either, so I guess there is no strict rule.

The rule is that if something is unused, remove it.  If it is used, keep it.

The rule is sometimes forgottn and therefore we need to do cleanup.

> Was there a
> specific reason for dropping it here?

The reason is to follow the rule.

> My guess is that nothing needs to
> iterate over the report types yet, so it would just sit there unused.
> 
> And if more report types show up later, would you rather add the NR_
> member back at that point?

Depends on if we really need and use it.

> 
> Just asking to understand the plan, no strong opinion on my side.

No worry, thank you for asking the question.

> 
> Reviewed-by: Enze Li <lienze@kylinos.cn>

Thank you so much for reviews!


Thanks,
SJ

[...]
