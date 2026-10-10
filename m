Received: from mail-ed2-f8.google.com (mail-ed2-f8.google.com [74.125.228.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD01B7910
	for <damon@lists.linux.dev>; Sat, 10 Oct 2026 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791591816; cv=pass; b=fGTs/xhXrZtrUjwEdTQhSRkIM60RknO/7NtGI9cvsc1zUrIadmKh7MKHDByrdMInfNIaLJRZH8DZxRyzEAbJB3t7CIyZxRMOVy9gpE9v1EOW44GNMHtZTNe64HZDurXH5dNcsQ1grmqFFOUkHtCdonQXk/tXYT9aNk4MeLeDQy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791591816; c=relaxed/simple;
	bh=Z2JW9LIkFMXkPvHGM0Dgtv4gTXM2c3LF5UF6k5I8+HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b60bIPExCr3kN2Fv8FxWGfN2cSHXaFtQ+ufFht4bZHa2LLCR0+SC1+UKxUdbMh5iGzHGD7eb3D59Yn8R6ZqnVEyUa7rEmSx5YZwFGoIm9zr3GeCsOn1SF6sns9xpG5EZjTqaNQTw6qbb5M9E2flFbvfmuyu2SLrNlC+yZNaAho0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK315eqj; arc=pass smtp.client-ip=74.125.228.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK315eqj"
Received: by mail-ed2-f8.google.com with SMTP id 4fb4d7f45d1cf-6af61a7c893so137700a12.0
        for <damon@lists.linux.dev>; Fri, 09 Oct 2026 17:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791591813; cv=none;
        d=google.com; s=arc-20260327;
        b=Y5H0Tb2qrODy1m/w1f1KbF+66c+LEuPeqa0Pcv6o5yS5gg2Zq74+edhMIBXmohBLp+
         gt8XZFNnO6ZF4fcF6D3cKlw0ukef0bOGMe2TrEgWnS+CbAr5twhE/RmqYKrBpMicOCF0
         8SWw7yqMDKN8mdGzICyw7v5eGtwmMSd5Nr/69CpG2U9APfsdhXayJJlnjhvs2nNbY25T
         R62xEcBcCsC6H0IJ5ix+M2h+kfv+mryO+pxQvHpfuKEf79q9L0+hQv2VNYz/TVBPuxQ+
         EV5t1obZz/rCyLIu5bb6Sg/tkqnSmK+PxZJJIIfUHtGyf4oAf8iPWow8ZJbFUV4J0FXD
         B6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E5Py6HL+QggVsOTpYoDRwjrwSN8ziJN3Kv+kCMYmLTg=;
        fh=9r+T4FZLSZ8Jec/j0WfJbeQxdFh/lpw5Cp1NsnRN5pU=;
        b=pqjXl/1gfJ4yqjrHAdLa5tEk5BvY2z5R5cRrlDJFGsXTp4OBRCVCb3TL3I5d73eSYt
         FBrsUCc5sZE330FVNsxB2Xjd05y2GPBLFMUI8oxgo4NVnTatM8JlRe9aPQxxsdwZ+mVS
         K3hUOGXfwfUuj9jQUk1Bwru+l+CCVzV9RKA63ykg3RqqpaJ7HyDBV3VZcoZFj3ou1iA0
         FoOUBqx/nirH7RiHtO/bjv2Pfz34A22FAG6wCKVz47Y2J6k0PL2zf5p2sGNab7/OHlRz
         pj5BNMD0WqUYmHLuy9DulQlozJrpDLD8dHniAAElajHP3yEq2gDRPM1MGCAS4Mdsffei
         d6Xg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791591813; x=1792196613; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E5Py6HL+QggVsOTpYoDRwjrwSN8ziJN3Kv+kCMYmLTg=;
        b=aK315eqjL44hetvrzzXHf0rHsEeqv6gz9sqYLjsX44P8ywydTr+tAnxD/Z+st3S9WS
         i9A6EuDcpSMC2Wn/1rwmsYlC3I1oPFZJ0mwU1soLvB20fjS4zJ67vrMF/U5OwQ8DUree
         7zwZXmlX8dONs4BbOXVK9CP1gMid8PrYNcZYWSK/hPAq4ShYM5hzrmH3En4VDRxbM4y0
         B4QVN3Kk1E7K4nNQhaTt0ekTwIkzlJw726Y9bKAJat4msrn8mcbhsIzDNA4Q/5NLXZyJ
         w2hgaiUubepDLd4otw/ywgAcB3viBleLbrzUWrBjQTefIItqvJvZCG6/p+d0Pfa4bBrc
         1CbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791591813; x=1792196613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E5Py6HL+QggVsOTpYoDRwjrwSN8ziJN3Kv+kCMYmLTg=;
        b=c4FE/F74QHuN8nl/oUxs0c/eCQRzR1dhxqXDSXgqKtcmbNuDgk2o98iG30F+OUFbGn
         08bisa7lTfHuaWzNV76icxslwHvGrtXu2D5dBRmPzbuN8WnpEJsea7bZAzyFEmm9iEjx
         BsN3JbH1y6lDR4ZZAQoTonv2TVHmL5wL3xpZLzdMtrHpWo5RlTn2BnfO1qRVOksB/8l3
         QDikPf4BbcV/HkgQgDzU7m99vmdVhdRbhMIx2abtnjOdbcMmxGWwCTLeNRnpejNuTMgD
         I6nH26lpWZXjpRa9M07kD+9gvHg+LFQuegzUyNmNPKrU50ToQ1CAKS0cwGvcYdQCCxsW
         kLLQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1CWNwNUAUmccbAsXj0p4FRtgL29w2zqSQi/r9poS9Ps4LFdPJvGM7sx8JPL1c2JsgOgHzAA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJuSyhQChx7eA4th3Rs0CWAHN5EwdX9j5W6iFSnVhISUqmz7SeV
	hj7ez916narm6/ypG405e2pCzAHYgv8rugd/NdfSQAluHVHBPsbEMmFESaJlnh0OABhRW1X/c+e
	BxVewu0dPNPZnNOkaKtoigFykNqxBEQ==
X-Gm-Gg: AYBFou2VCci7l27xU5EL2zoAjQxJf35nFL+aWtzrbbtCBKYkCQYbkdD4j+PG2TbAsra
	4NDRoT2afYsO+3PYjfy2VVhYdprY66mkEp64KzD4y7VS1mHBAeo7tBouxJ6xVCnuUsEeU/7WL8m
	iCSUrGY/cEJVD2hlCqOpZ5o4vpaVh8vRaAnTYdF91DsJknAGbnGGtlB13IL0ayEExMTj6obEo6V
	y+H5EFX9irT3o1ELj2raVnqXfu9uO4KDVhnc4j4mzqZv73GU4eojLR5o7pss+OtLBDjioGqm6Pn
	zIWlblZ7KJoemOVJYHkB4lOxhZfGzFhWiXwY2yy4hmQuKqCOTSE1yB19w9V3LuME9fy9
X-Received: by 2002:a05:6402:4490:b0:6ac:9a44:d412 with SMTP id
 4fb4d7f45d1cf-6b17c25d32amr3176429a12.7.1791591812741; Fri, 09 Oct 2026
 17:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003202727.3673-1-ravis.opensrc@gmail.com> <20261005100435.1211485-1-kunwu.chan@gmail.com>
In-Reply-To: <20261005100435.1211485-1-kunwu.chan@gmail.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Fri, 9 Oct 2026 17:23:17 -0700
X-Gm-Features: AclHuK9H7NRLbSCaBe_aB3pxVn0sHlmdw2q3s22R7c9utOO5Z_szeWimYSsPy00
Message-ID: <CALa+Y17i9wN=0oLbbrsPafJY_KNEoKwZPLdLCrMq5Nf2k3aVKw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: add damos_node_eligible_mem_bp tracepoint
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, SJ Park <sj@kernel.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 3:04=E2=80=AFAM Kunwu Chan <kunwu.chan@gmail.com> wr=
ote:
>
>
> Hi Ravi,
>
> I agree with SJ that this would be more useful as a general quota-goal
> tracepoint rather than being specific to NODE_ELIGIBLE_MEM_BP. The
> target_value and current_value fields are not metric-specific.

Hi Kunwu,

Thank you for the review.  Agreed; I will make it a general quota goal
tracepoint, as I wrote in my reply to SJ.

>
> On Sat,  3 Oct 2026 13:27:27 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > Add a tracepoint for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP quota goal
> > evaluation.  The tracepoint fires once per quota-score computation when
> > the goal metric is DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP, exposing
> > context_idx, scheme_idx, nid, target_value, and current_value.
> > current_value is reported as the quota tuning sees it, after the goal's
> > complement setting is applied.
> >
> > The DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric expresses node memory
> > occupancy as basis points of eligible bytes.  This information is not
> > exposed through any existing external interface (perf stat, /proc, or
> > sysfs), so the tracepoint is the only way for userspace to observe the
> > target and current eligible-memory basis point values at quota-scoring
> > time.
> >
> > Link: https://lore.kernel.org/linux-mm/20260428030520.701-1-ravis.opens=
rc@gmail.com/
> > Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> > ---
> >  include/trace/events/damon.h | 31 +++++++++++++++++++++++++++++++
> >  mm/damon/core.c              | 16 ++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/include/trace/events/damon.h b/include/trace/events/damon.=
h
> > index 8851727ae162..2c7249cc7c88 100644
> > --- a/include/trace/events/damon.h
> > +++ b/include/trace/events/damon.h
> > @@ -74,6 +74,37 @@ TRACE_EVENT(damos_esz,
> >                       __entry->esz)
> >  );
> >
> > +/* Per-tick DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP goal evaluation. */
>
> The comment says "Per-tick", but the event is emitted for each matching
> goal in damos_quota_score(). "Per quota-goal evaluation" would be more
> precise.

Right, I will fix the comment.

>
> > +TRACE_EVENT(damos_node_eligible_mem_bp,
> > +
> > +     TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> > +             int nid,
> > +             unsigned long target_value, unsigned long current_value),
> > +
> > +     TP_ARGS(context_idx, scheme_idx, nid, target_value, current_value=
),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(unsigned int, context_idx)
> > +             __field(unsigned int, scheme_idx)
> > +             __field(int, nid)
> > +             __field(unsigned long, target_value)
> > +             __field(unsigned long, current_value)
>
> Also, context_idx is currently always 0 here, since
> damos_quota_score() only has struct damon_ctx * and no context index.
> If this tracepoint is generalized, it may be worth considering how the
> context/scheme are identified rather than introducing another tracepoint
> field that is currently always 0.

I kept context_idx for consistency with damos_esz and
damos_before_apply, which carry the same field and also pass 0 today,
since a kdamond runs one context.  I will follow whatever SJ prefers
for identifying the context in the generalized event.

Thanks,
Ravi.

>
> Thanks,
> Kunwu
>
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->context_idx =3D context_idx;
> > +             __entry->scheme_idx =3D scheme_idx;
> > +             __entry->nid =3D nid;
> > +             __entry->target_value =3D target_value;
> > +             __entry->current_value =3D current_value;
> > +     ),
> > +
> > +     TP_printk("ctx_idx=3D%u scheme_idx=3D%u nid=3D%d target_value=3D%=
lu current_value=3D%lu",
> > +                     __entry->context_idx, __entry->scheme_idx,
> > +                     __entry->nid,
> > +                     __entry->target_value, __entry->current_value)
> > +);
> > +
> >  TRACE_EVENT_CONDITION(damos_before_apply,
> >
> >       TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index b63e60ef8990..6ddd15dc4f55 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3294,6 +3294,22 @@ static unsigned long damos_quota_score(struct da=
mon_ctx *c, struct damos *s)
> >               highest_score =3D max(highest_score,
> >                               mult_frac(goal->current_value, 10000,
> >                                       goal->target_value));
> > +
> > +             if (goal->metric =3D=3D DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP =
&&
> > +                 trace_damos_node_eligible_mem_bp_enabled()) {
> > +                     unsigned int cidx =3D 0, sidx =3D 0;
> > +                     struct damos *siter;
> > +
> > +                     damon_for_each_scheme(siter, c) {
> > +                             if (siter =3D=3D s)
> > +                                     break;
> > +                             sidx++;
> > +                     }
> > +                     trace_damos_node_eligible_mem_bp(cidx, sidx,
> > +                                     goal->nid,
> > +                                     goal->target_value,
> > +                                     goal->current_value);
> > +             }
> >       }
> >
> >       return highest_score;
> >
> > base-commit: 763ad0211c7b587344f03bc4d1299810aeb736f4
> > --
> > 2.54.0 (Apple Git-157)
> >
> >
>
> Sent using hkml (https://github.com/sjp38/hackermail)
