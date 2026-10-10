Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD4628E0
	for <damon@lists.linux.dev>; Sat, 10 Oct 2026 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791591030; cv=pass; b=Tu9IJvV/PLQNiqJ+NMAeR4WOHL1KCGX7zTkDYPwEAnhefVA0YfPbxGGv3AXrTIXYf9NEWus0Nu6z34TzXQHZvcqjFcmQ3cq19gZ87ssz6/8xSWUC9u30zhlnlmcnFS3v/b8oCQ2jXxTPWuYiOyac+RkDiJgCyd16xEZiHq80IWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791591030; c=relaxed/simple;
	bh=VDF3hQxEsXwOOEKMR7uFIu2BM583vjfhY7iLbnx2e6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4BSci3I1wZCpbg+WGU06CVqPeauiAgoLodRanu3ynWbyRrafLS8H+oSPkp9mehmx2u5/jQqxuLWaYHmLE0vwO3EDmqi5vLEhjFLuL5zaBApUT9qqkandQ1nEFz7is6tzhMYL3i8z1ilanmm6iWoxZpciWu8jlNSUlw23fip2TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUEF+/Ao; arc=pass smtp.client-ip=74.125.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUEF+/Ao"
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3514b7a0a23so204299eec.1
        for <damon@lists.linux.dev>; Fri, 09 Oct 2026 17:10:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791591028; cv=none;
        d=google.com; s=arc-20260327;
        b=G/czUs9JMVjJ0A1Xn9xUL1eZGgKKgMtmsHImkFkA3MCZiqanPyTg/bC4XY7OQeZ9Lf
         6r8zecS322grhhBLwTS6HqBc/eHnufEgQVBzLPn5bP2zOieZ9QMmlUykx7mfUec6OhBL
         4F0OGdzkrVMK16gFjC52lOix75s5eSTUe/RV+nMoMrtZ1w59EV46ugZmBp7Lt3hvoHkM
         mop/yXRD2jFnG3PLwgVgIsobCfloZCU4uA0a75q90UVEBVvJZEWXQn/DBKnt8Jf5HGgS
         KltfTVJyuU2y5QGRg5dbbUnWvlAXyGpjorg4Qq6/cpRoPonIXs+ibt9LZHX4ze6Fz1jZ
         MAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cR/CPJKG3NoiCnDGVGJZMEP7USNRf/dhi11bwg0wPvE=;
        fh=n771C3jAW1f1gzMmVnNoujXSuCNMiiBQpv135+ajzLI=;
        b=nqEmTMCphU/A4dFr9PL95gFvP0GA9R7ACbem5fRqdIvJraeU3C0GTgLg+Y7xwS+1J8
         hun1dZZIydgzTDKZ7uVYib0aro1SCy+fY0vZOHawWT2WuOSxy0A8lA0pM2t3DZumzFn0
         fkKKLNOT3tpy7cKMrrv7aumxuR2jmH7kyRRL5ACbU0mirIvDNysA3E2A1C+fNHwfFdTG
         xAZhwvM1A2DzSIFJe73vT4OPBTF4mzoV/rmiUkhL5HVQAq2cmA5y9Vht9VQ3bHMDG2lR
         t4p8S+M80ianhisc8Hmof86QjZMCeg/m0fo+TJkM03lfVDkXvqcZt7bMY93eylxPTxA0
         0TSw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791591028; x=1792195828; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cR/CPJKG3NoiCnDGVGJZMEP7USNRf/dhi11bwg0wPvE=;
        b=VUEF+/AoeVuaTGNYL96lCmOjBfLBEtftpzScYGYR6cSQDDtrKX3rB2VCKxbkJBbp0V
         KCbscNzaARCJaVWLIJLZW/AfOzHjibHUqxdv6Z9w3kG8GZdrc5InAkr/NSnzSLMwKkJL
         5IVZyxV1r8FC5VyMxX5SaOpvLxNwUq7KjL4C7VSdT4EVCeHyCEJQrTnUwiss0UzmPDF4
         HRGn57OYwhu1eW7eCYflntdcxhx5u6enNy2WzsLNMfT7l08syizg9Sda9ZSwHFS4oK1j
         aWo8NtxT38M8g71hUkyrWeG4xztmUs7yKD9sUwtQH+LpOt7QIu4nuQuagRYUczKvCcGb
         qxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791591028; x=1792195828;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cR/CPJKG3NoiCnDGVGJZMEP7USNRf/dhi11bwg0wPvE=;
        b=TUAIP888Yzq27rKFu3uEvvKXtcuHpTVupTzUZ18Hl34ohNOG5yenrrC8Sp2z7AIB2o
         lfjmGpZq3MmyLOnnSfcZRcb3G9HTK9BMMHuS5XJmzcjSI+WHAQ2DVlgQCe0iL229Ehhd
         kT1Qw+wA/NoyQzu8htpHFXahyO8fQ4e+F7tadysRnDwoiP8zo/pziGnnRgb1btsFMSr0
         7ECqpoQuuWkcGKcdILh9w4fC/qKPL5NAQ1aI2b9+t+qQUr71ZFlNS2SXf/97XlLlYjb1
         /PfKXHEHnlfR+XCFvaXen4HzafNAov5VQZF0TNnDSgke7IMARLoLX12TaegP/Q0lHFuW
         mOqw==
X-Forwarded-Encrypted: i=1; AKwUvBwLF9jk3Vk+vZn7o+TelEZNgIzR2WXZF6deoUqF26aqyh9RZMukMBfr3Zj6lXpAMtzBOoo4sw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIvXmqzaQkfr2Q29gn0eDBvVJqkHRfqmQMItt/gZAaBPTsZcnZK
	kJoB7TvvlEspQ3+kDVqOMYbRGf1pNin7fiHoegV/wdWMahbmNv/UFJ5gDco8+7V2SGMhKw93yGr
	1JE0y7NoFlhutby8T3IVepMxyifep3R7i/xY63pTr
X-Gm-Gg: AYBFou0aizh/myiJf0SNG9QEtC5XskI/9qRx40B7BIhlpaSuIDWkgiqt+76L8oBJ6LO
	R0Kr1Im3aHYP1x2npECo3Z10LwrustCKP5AEwM86KGfGZ02DfChTyQ1oY1VD+rfdSCYUtbnY0k2
	P+Uh7Iur5JQca1ALTQaP5ypddS5eBPLhuYTc/ylGr9wjiSpdZu7MO9OQMbn7naaEODPcwtUtieM
	Gcz2A+NgCXXlMC8uD8UVLUMO+li+PAVaKemQxbxyqdfc54bNn6HAFefp5eK9V5xI6bRAiIlclRy
	k9X+RB9LkqLspc2HDgusYum5cUlPnlityVn9cQFhCwkRaG0ww2hda6dz
X-Received: by 2002:a05:701b:2607:b0:144:f096:4dd1 with SMTP id
 a92af1059eb24-16a611c76a1mr3960393c88.41.1791591028199; Fri, 09 Oct 2026
 17:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003202727.3673-1-ravis.opensrc@gmail.com> <20261004080110.37328-1-sj@kernel.org>
In-Reply-To: <20261004080110.37328-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Fri, 9 Oct 2026 17:10:16 -0700
X-Gm-Features: AclHuK9iErDpI0ky8YsjjXHUJ1Bhqg2BvHDmttXO2gzSECAslgV1ytghZLxTEaM
Message-ID: <CALa+Y17H55dp07Td7oqhDPq0TmuWHFB9DNcXNZ91Su_di2vhnA@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: add damos_node_eligible_mem_bp tracepoint
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 1:01=E2=80=AFAM SJ Park <sj@kernel.org> wrote:
>
> Hi Ravi,
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
>
> Thank you for this patch!
>
> We have damos_esz tracepoint.  Have you considered using it?  It doesn't =
expose
> the current value, though.  I thought it wouldn't be real problem in most
> cases, but I can show it could be problematic for node_eligible_mem_bp ca=
se, as
> the metric value is not straightforward to see without using DAMON.

Hi SJ,

Yes, with the temporal goal tuner, damos_esz only
tells whether the goal is met, not how close current_value is to
target_value, and damo needs that to know when a step has settled.

>
> If you really need to know the current_value, I'm open to add a new trace=
point.
> But I think it has no reason to make it only eligible_mem_bp specific.  H=
ow
> about adding more general purpose tracepoint, and/or update the current_v=
alue
> file [1] under the goal sysfs directory to show the current current_value=
 for
> all goal types?
>

Agreed, nothing in it needs to be specific to node_eligible_mem_bp.  I
will rework it as a general quota goal tracepoint, emitted for each goal
evaluation with the goal's metric, target_value and current_value, the
node id for the node metrics, and the memcg id for the memcg metrics.

I would leave the current_value file as it is for now.  It would need a
stats update command or refresh_ms to stay current, and damo wants every
evaluation as it happens, which the tracepoint gives it.

Thanks,
Ravi.

> [1] https://origin.kernel.org/doc/html/latest/admin-guide/mm/damon/usage.=
html#sysfs-schemes-quota-goals
>
>
> Thanks,
> SJ
>
> [...]
