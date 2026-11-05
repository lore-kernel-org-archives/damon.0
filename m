Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793900344;
	b=hyj3nOCBhLFLKiznC7lf96T7W5HGHcNkUbyC+jHPEqq9VslUBKTQu70qQqP+95qZ+/gf
	 gXjUwOealleicXPOuvVBy4ubKPpwBX9FzX8ffTtyTgNIMncv2IGl3HNlKg13uV1B8t2HD
	 5emUIzQJ7PEU97qYYtXhOMcOiY23PNJB5pt8cU9wHKbBJorJC42f8RcebeU5EMCAP1clP
	 vVK0TzvI1zcHHX5wpnjxVZI/7kfsnTvlfOpqlLB1+GCY53mIAX/qntl95amtPSdGr8/34
	 wgxC0HMgWExefVjfbK8P0YsAFQu/2QXuyMBPpEotraSPWxtNCxhYR1aKA14o/n1hNBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nqw4yirBXK57TsA0wfsU6JHIgj6p3RFArPkzpDymZNI=;
	b=4DeN3wsN/uHkNxsUQO3MgAnQkzot0LrzIKZonZtMYnCw4GMJ8Aj+mVpoEJ6tS4VvOrQr
	 jUgOfsvz3T5ZlJljDuQBvRwLW+w8lnEspAFeMB/REL0STm77fiByBq5o44V1RU51fD1rf
	 9c75RDFozfibFOiHrkHayccIe+KGzwNG8yh+8g6oxosJGrxu4JCaIVELl9UJLnrMhdUYO
	 j4tnZ6wUPKshMZCS9QYaMoTykL039WwEcuAIGMOQjJk3zQd3leCGWQx1cbaUTIDEpe16H
	 VYBQ97n3N+BDgN68gRnaTRUbb/B0bkvz+sDp0PewX1EqjrPbhZucpA+iU57uwevga8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lEF5xTnQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D20606A328
	for <damon@lists.linux.dev>; Thu,  5 Nov 2026 17:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22D20606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lEF5xTnQ
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1992516f8f.1
        for <damon@lists.linux.dev>; Thu, 05 Nov 2026 09:39:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793900342; cv=none;
        d=google.com; s=arc-20260327;
        b=SYk9rYrEgPCEfwnF+GF96W0F5OLrygAnDm0Un6vbBgnzDDBgMG8MtT1p6ArpCQL9oD
         xY7updXKtJ4eHib5Rf6w8+5YxxTOYGkgchD7COiqVaYA8KVx4bELOMYxqd1/jAlpJwxz
         8n3GMhz/05mZU95FmjcQrLIEWXTpM6aRpjumRDNJd0v+a7/tW7a+SL4UfXhoCdHh9DtS
         xvi78d1pbUOcY859yseTXCB0RzHyHHsXcA2zzgNr+NCRbXvVAfq0n44briLULNwn3kiF
         xsSTpAacxS8EiCBHbuHwBVV2JV/VTw0C1otF9+0IIYw1CLKmktp2NaBX9+tbVRrNfSWP
         wzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nqw4yirBXK57TsA0wfsU6JHIgj6p3RFArPkzpDymZNI=;
        fh=yoruSGXsRMgQP9wtTjme2+87GCpCXDtMZNrLIl7zaUY=;
        b=TVxubLjFjWxFSO4K4NJ+bF2YjZZXvUiiv7DVSUi2VDSC6+wl/ul/1HgrjosFUJgqjM
         oUUns6BWR10AOrneB3udKCvY5hP9hnStCWvgm8Ji5vYDoXSYbrGs4rY2yf4Davd3TgIJ
         OuqNyUMEpTGFN7ae9lyfl/e32PtoxA6NR7YeY/rIe1o8O+rR4CEphuNqcv5l+ILQmMve
         Nn+PlHw7fKN8BQD2S1oriSzkMKL7hV2Twll6Ogj8If7LKnRIKcogAjTqYYM/j8kD12Ji
         gOcNgdfaBj/fEYscd3B/fQDhK40li8Tk84Iu2ltXARiL7liRTUN5XL63ljA/rma8MXAO
         81EA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793900342; x=1794505142; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nqw4yirBXK57TsA0wfsU6JHIgj6p3RFArPkzpDymZNI=;
        b=lEF5xTnQgsPDHqbXe70ceXLQy0EAvMnefjWzU1jVljy8ACGDA3VmcV+6wvgMg8arHp
         ZZmWLUjySpM9rZxXNLK0q48Fv9wJOnivm8dctppg46LWAYuU+8TRFVjRjldvfnuqJStB
         3kAp26fx2CX/ML4/wy21NcsnD7lpjEZhMlvoyvfD76ppCcWryz7sGRinfJDkBtr3JlIB
         IwI/LSPQB1Teuqi/FCzC4xxBeza+0Whza42xnD/Je0pYkeyFWectWarN0HLzzxIfiJyY
         7ebM/RcEbBtTYLpEy7XcCrksWhcjwowwKbylyPog2VQrei6bClqQezb3nFrkAfUR/42S
         k+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793900342; x=1794505142;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nqw4yirBXK57TsA0wfsU6JHIgj6p3RFArPkzpDymZNI=;
        b=urUjDg9oijKCY2iLdenPg4T5xFSFeDOtt6cwcaa2CVBgFLEVqK/hznF/Sffkm79QlG
         rEuPREFV9Wf96c6A7xHHWuOfmbEms8y1Mk2iUExvEncgFIwoxXYE6C9TIuloi4RhX99O
         AE7GwIhZPjMfFyXW89Bop9pmhSAzwiOLUFQkPznAoAfpNDnR2Aq3tF0LgAljFl1EBo4u
         ASzr9GPaIjlKVAO0SElGFcOWOCa23WZhZ60ZbGxKp55KIeO5vAi6rUSpl6ApenSXmHnO
         /npFWr6lPN7C6JbzojOSnLJ5DdgirDF91ZSBQiBU6Sx17ipw39R2CyQxjZYrvctYG/6i
         HWuA==
X-Forwarded-Encrypted: i=1; AKwUvBzq6wb5yQ+tJnz4Lhcth4fPRB8EG9xTO7hX9Muvjvfx3rU/QknuCJ/Ay3BOrbB2k3xYX7ZaGA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+6E+EpT7PB/TxuHNL04Yjl6EiphuDTI5wdf4fY8siGTDH/Z7D0
	js7jKg3UbqMRqpGOA7ejC3JzmbaMuFkwAVW/6nkD7nDY/sfpTak/xzls7ud5cm1rlzOPAjUy2Xf
	Hs0L6qaqXOoQ04FdQNvpZSrPPJHBkKeg=
X-Gm-Gg: AYBFou1xiKE4iZKR30W6FPxjSJzIwZ+ydes/Zl7hor+MD8IHBO//OsfDnKKGzfaWGBh
	RkkffkEgvnv+QjOysJyWlyuHt4kj9ZX+o+CBn68gn+Xvmi3UbRRZXFh2Gr4DsmACz13txn66eHh
	Iw/uevNQa73uDfFrPua4ce0B5vTW2IwiggwXIvnGqDlAGV9NB+jksZQR7tQJJWL4z9EIQt82LB6
	Jy0giGkuQ4rXLdR0CuvBYJ2bod9UJEtraMv3xR2CCc1T33qGwpEAEe9AeIN3oeXRDR0zTp1kHSg
	O/bRe0IREKVfDucy+KYRqRz/9DEbMp485ZJq7EXbc7Gzk1JOMgfDp0BatXtpQBfQw7u1MmH96A4
	0QOL9cdW7jD2LPWngCVPf7KdiBt+2Jxod9N1dlO6eQtjXukyLzyopK1wsUEWTGPQn9+Qqike63+
	TTa8dKND79RzReMNO1gThZ7yziO3tDgIeUoYqfaiq60LuH+Y1xy5+Q
X-Received: by 2002:a05:6000:5c9:b0:48e:75f:477d with SMTP id
 ffacd0b85a97d-49273e5b2eemr704427f8f.7.1793900342253; Thu, 05 Nov 2026
 09:39:02 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261102225030.2743129-1-joannelkoong@gmail.com> <20261102225030.2743129-2-joannelkoong@gmail.com>
In-Reply-To: <20261102225030.2743129-2-joannelkoong@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 5 Nov 2026 10:38:51 -0700
X-Gm-Features: AclHuK-snOd3ku1r5RN2yfgSJS1XUyMqGhPauQIZ7tv5ax41vh5WTgomz0EDQZ0
Message-ID: <CAKEwX=MBdWEuKZhi_g3Rq42ytwmn7h3DbVhHHmPjOtVfAKceTA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm: zswap: fix shrinker count for the root memcg
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, yosry@kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, chengming.zhou@linux.dev, sj@kernel.org, 
	david@kernel.org, ljs@kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:51=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> zswap_shrinker_count() scales the number of freeable entries on a
> memcg's zswap LRU by the memcg's compression ratio. That compression
> ratio is computed from the memcg's MEMCG_ZSWAP_B and MEMCG_ZSWAPPED
> stats.
>
> However, for the root memcg, the zswap entries owned by the root memcg
> itself are never accounted for in the stats (obj_cgroup_charge_zswap()
> skips the root objcg, and before the root memcg had an objcg, its
> entries weren't charged at all). The stats only reflect the entries
> owned by the root memcg's descendants. When the root memcg's descendants
> have no zswap entries (eg when the whole workload runs in the root
> cgroup), the shrinker reports nothing to reclaim for the root memcg, and
> its zswap entries are never written back by the shrinker. When its
> descendants do have entries, the root memcg's entries are scaled by the
> descendants' compression ratio instead of a ratio that includes them.
>
> Fix this by using the zswap pool-wide counters for the root memcg
> instead. The zswap pool-wide counters cover every zswap entry, including
> those owned by the root memcg.
>
> This also gets rid of having to flush the root memcg's stats, which
> flushes every cgroup in the system.
>
> In a VM running a reclaim-heavy workload in the root cgroup with the
> zswap shrinker enabled, the shrinker wrote back no pages before this
> change (zswpwb stayed at 0) and 1016 pages with it.
>
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Acked-by: Nhat Pham <nphamcs@gmail.com>
