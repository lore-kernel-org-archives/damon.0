Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9523BD06
	for <damon@lists.linux.dev>; Sat, 10 Oct 2026 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791591672; cv=pass; b=YQqpO1OW/V0Xg+XHg7qzC//dRMzw69Ef88Eq1PX/3FHm2tL5qES/3oHMYvo3GEk5iu0NBl5chRpos86PG+Cn/7gVlpTFN+Fm0FVfFKOAXDWYa3x5FHqN4NhPiIVPS12UOqSSAxNNK6n/sjLGkMdTrAle3A0fW2q+alw7Q4gwIVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791591672; c=relaxed/simple;
	bh=HxAWx+vouM1rFRwo1u+RrW+BszfFH2h14d83b6DcrnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEahN3hfjXYVElVrVgmP6bmXEuPs9ynqGCCYL4JnI1XhCX7vT8fRb4pTODeYc6ZUzDHVAYNIvKgsIeUDOs5Z0L7W/LKBJMYVz03CDupk9CI0I467cPKbYlDW9bWBcwcZFROC3sWMyXgovmrZSpbevuaIP/ozXPFTxgY75g8misg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqPUeQeW; arc=pass smtp.client-ip=74.125.229.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqPUeQeW"
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-139b659a45eso59609c88.1
        for <damon@lists.linux.dev>; Fri, 09 Oct 2026 17:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791591670; cv=none;
        d=google.com; s=arc-20260327;
        b=jsMhJmiSlWnIgS89gG8PZdusyIR9YvMQd5UNVYSNjarzIDLHnQv5mdu4cDJThsc0NH
         dVIRrILlmKh+7CxsJgaZX8Tvg6cTXS1Bt84+QRJOlFFcTq/76pv59CjFLVEYQQw+lGzU
         iWFmFmn7v4XLVv/99Oqtzo0kw8do/VsmN+BrZZeg7arKJT+2ri2kVTnpoyNWX/ti0S3W
         uFteBMU7Itj/I6CWYiBso6QVJtgtXurLEDHswsp0GKYadFcuiVdC/8ofDGD2AJdd5auM
         ng9QXhCTmxyK9kDJPj+VSgRigNQ2SoPBm/nyBTEOyeu0wsh0CN9e9y0C9vuz0wPHLQ35
         ChHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aLhgNbsx0+wXZ0nMHKkwbYkJUXpFXWO/o3bDIihSveI=;
        fh=bAD/fm+3bJ0+60BOWE65q6Rs76LwgNXZzD35cK15Y+w=;
        b=KqEIE5WnpCxQjikdUBkrTQ41ntmRjNxdqfzCZ1v/7SepGXVPropL4RwPmA6ciPDtdw
         uSc5q4dLERjfPNPzsSDN0TlKpkOfjkM4MBC0Swut1f8yGfusKnXo8U0xWts4pFE21X7r
         e+rotnXwBcOB9K/tS/bVdX9/Qsh/3WsAzGERaP9GlAsakM88GXKxRUUaheME+PHei5W2
         MGsZJw1s7mM8girdIDculzETTZdDgJx2MxNNrWIVWMwQPD11gIcA+qe0Nuc2zDdf0/Ak
         dRUzyAuF7vuq8wRTyiDDQKECFZ4qoF4BSiGxUCFHi17hz2XjA2zasS35uB/mvjO3tOg+
         QZtQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791591670; x=1792196470; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aLhgNbsx0+wXZ0nMHKkwbYkJUXpFXWO/o3bDIihSveI=;
        b=IqPUeQeWqc5CjuQAQMXjYHx0cRL3prOtbSm2RqREJlL+2e2j+Mz2W4vxDRW/7N2Eq3
         lQho4r55JLA7DZsFKhA+GiOLJ+mMsTT1OPub+E2PuMxsTnPVc1OEtX84HBacbNFoWMqc
         azRItiBlGfrcOfxxdLDCLfrVcyRXCoyGPVcReVi15q3IzL+Nfy4Z2MEDAzBsqsV8y0nQ
         jZhnpaqdblIM6V9zjQG1U9SlN4JE3iYTcL/YW67eIwQtKgmQWQivrWxUTyRpZHn2toDx
         LaMz8eLudPZ/KshirP9VubuoM0jvhkaJ7XlDHmhgirH9PWjkB6DdNtA5h7DGPJfiWvwm
         tt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791591670; x=1792196470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLhgNbsx0+wXZ0nMHKkwbYkJUXpFXWO/o3bDIihSveI=;
        b=rtyqMEeBQnuDbGHmLrV9f68d0th+YTGnooxUuGV2QAsVJJfvOOJ9v3UZYiuKMJ22mT
         NlaIQdKBKaNQTspq4u3uULcuQ3D4PSxD2WGPTCKiJeG36TGg5Zy5jWPVurwR4HQb1o5s
         j32ICTUANieJFihyLdZUxqN+r/hNHHVmzky0hVjRBHR/ouX608FOzksCY1WICPuO6tBc
         cpb50wIVDG1mNU5yA3th+eIdjXO0L3JdZUuPWnZwm7FmpWsapxmOFax83cZcxjMprQof
         QbaOb86QVogEMk5nRNWQajDXm4sbaP+4vwHY6C8TYR3NC0i/qW9iMFDzjgaDBinb1Y4B
         NhvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwogmv//y90SBs6QpVE8tovgWjBQCN7AHQKzORig9VwL9O9DdFu+6WflMp/QpgGOUWMYN56Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYKFI3kBO1Txn1RiAMdVtnN2ySD6gCqwr15XP6urz0e31ENBr/ZN
	2F0eOGxsatOVZGw3GTMaYJOuO5Rwj5morWOQpBLUiuYJCLo7QiYjPRGKp2JLr6VO56L9jP/rQ3t
	mPbkMEQaFUOYhWqjjeRWMNU28+71cuA==
X-Gm-Gg: AYBFou3R7qGJrQo3DKFoBJ2tMAQzzn3HP7MjQ3ljgHVpZb/ch2ltJ1bnsEOGQveo5RB
	2JUPYlB85xpvyUu6fpX5mdr6TVzsVJt08LVVf9H/cg5Id/0jv0I4aEX0ra8l9gV1pZuHmXuOksC
	mYQFq1HvHQWFuDmjmF52diwoCmYxOGXn7+BpJ3hA5QwycVJN7uKr6Q38eqY4c7NG39XktDQkRqb
	ZAFYSLuTLnbef03TJz2FDAHZidhgPnufpLdQwHZW8FkqjqthAFHdsr0tLid4N5OyDsaqE7M1ZKi
	P1xnyMep5VChvW08FnagEApwDvPyasMJ5Z+9fZMUh6EOW6RiwRrRXEvPwAoiRekA0no=
X-Received: by 2002:a05:7022:1584:b0:143:4d12:396d with SMTP id
 a92af1059eb24-16a61a6def5mr6220928c88.26.1791591669725; Fri, 09 Oct 2026
 17:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003202727.3673-1-ravis.opensrc@gmail.com> <20261004051632.71726836@fedora>
In-Reply-To: <20261004051632.71726836@fedora>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Fri, 9 Oct 2026 17:20:58 -0700
X-Gm-Features: AclHuK9WQbXCtUH8jjgwOQuphF_nuOqJSSeO2P2D0u1Fn7EltapGuD6HQRfN-gs
Message-ID: <CALa+Y14+pGN+ZA90gALy30mvrmkTp21AVFrjfzP1AtYEo-uVPw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: add damos_node_eligible_mem_bp tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, SJ Park <sj@kernel.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 2:16=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Sat,  3 Oct 2026 13:27:27 -0700
> Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
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
>
> Can you move the nid after the two unsigned long values below. This
> creates a structure, and on 64bit machines, this adds a 4 byte padding
> in the middle of the ring buffer.

Hi Steve,

Thank you.  Will do; in the next version the 8-byte fields come first
and nid follows them.

>
> > +             __field(unsigned long, target_value)
> > +             __field(unsigned long, current_value)
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
>
> If you move the trace_damos_node_eligible_mem_bp_enabled() before the
> goal->metric check, you will save yourself a branch when tracing is
> off. As the trace_*_enabled() is a static branch (nop or jmp) it has no
> cmp branch, but the above will keep the goal->metric still exposed. By
> swapping the two compares, the goal->metric check will be hidder behind
> the 'nop' when tracing is disabled.
>
> -- Steve

Makes sense; I will put the trace_*_enabled() check first.  SJ asked for
the event to cover every quota goal rather than this metric only, so
the next version may not need the metric check at all, but the enabled
check will lead either way.

Thanks,
Ravi

>
>
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
>
