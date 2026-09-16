Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E50381E9C
	for <damon@lists.linux.dev>; Wed, 16 Sep 2026 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541468; cv=pass; b=IhwvdFzggljwTI1gvfnJ2vxZl0wEBMGojZBR7u46MFfQ+VG8Q2RlldUp5dY35ftJYCVcbSNtWHz6oAELFm/GP8Ye9jcUjDuFfj3JRhSl1LSwfd4mvRttdr5m2XCu3pvkhQUXHMaSvLBkjkAJQbIB8SLpxC5s5EbYURWDa7PsBLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541468; c=relaxed/simple;
	bh=7fmSOz7iXB5a8XLL2bezW2+ceV14IeadbCUEVSxZg+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTHZ/4nQ0R/SNtx3bOkyz8tlx0y1Re6B733e9JE5AsyA5xVorPrxPtQj8duH8CfaxxgTtv6UH9OLhD8Wa5LrsCV/rqSSZ/uNC8rfp7HT1MognR4Bt8KLl4pI7lgkKamoKPK4tt9BN5exe9NVEiiKZFt7bgYiXaqdoEiDu3I+gL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at/JnrvK; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at/JnrvK"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4ad9so2781425e9.2
        for <damon@lists.linux.dev>; Tue, 15 Sep 2026 23:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789541464; cv=none;
        d=google.com; s=arc-20260327;
        b=YXqVIXJHy4USPcnmYxVjRCLa+XpH61ySfjYSHdin4LyyL8d64x+lDp9MVTh6PXuVy+
         TgNMUmfTTnhg7/+PZqDRUq2PYHoldaxjXqY0j/rHATLbKhZzyMxrQaDP+XpjY7Xtzq2F
         3KWYjG8lNhN833OdEhzItDJSuaCh04WJ5W+ixaP9x5lMdktNvHW9IZ9MlhCWEtG5aQ6V
         iVW4i3vWQGRyZZARyyU/oEaUIvf3ver6Ax4l7rr2O6IoywGkCHexeOQ16NyLf+GQ0rvr
         RsyNI8N11ZMUje8Cz13dyfhZOIYoNHtiY1ZRTjLDF4lm+9hxUKPowmqpk7f9fGNbHJCn
         SyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6n5rbrY/01roG/1TlDqdvk5Po6lB1Q7LrGFLCfNfZQw=;
        fh=r9LmXaJvIgbJ31s7azL6Tc3CZ13NHBinfC6lTFwOWDk=;
        b=NZBuAHrBdbWIhEVghPVsmXsDESUUyn8+0joTn8sSpJokQ1YtNCbBcaKln/x9YUWAf+
         TRchwBwPK5g+VofRxmtZI00Ii8UflZCc8IA8nYomn4dJn6pCSx+/ArJFZmfpbZTMHYyC
         Bonzk6FT+EDq8KXwQd+r7SFgrOhgAPMSTCFwAdJ9vcPScGqxECb922dKo9fhCqHEbvq+
         RVxD0AHEK6Ghg6hxcaUPAkQHLb+N1radQEpqT7KqBXW92112aSlQsUdOkrDR1GAHume+
         mwi4t+JWptbR2I6P64OaLwwfEQmjo9+h0jEw0orQ5VHvsir+jIfmD+E9NBpgDufcGCma
         KNAA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789541464; x=1790146264; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6n5rbrY/01roG/1TlDqdvk5Po6lB1Q7LrGFLCfNfZQw=;
        b=at/JnrvKNNcwyRcoD8nYs8vO9ViOjOyBHt8uuSrLJT6LMT+Gg7+oRfK64BWR0SYeLf
         A/ITXr6bTV3rjJMajGCuaQCGClOJIfAVlsD8NUAjw+xCN9840zW3pfP1BTfyJaCdCVml
         DyN1fU44J8WSj1pyPkK0c/EDZPxyTLb1y9HrppFsURtrQIcYfKaA6HYXY/RqGl7u0O7+
         LxJ/vL5y1aFstWBqs7Wnq1rvUOMGSFJHJ5WqcJQAhGYaFtQ/nFl43NgaYJxbjAzIdbth
         pn9Xh4dTY+uCCxcr+l2x9NKuTxjcQvZ/egNsvxMuEGuUm39pICx/2sip9K3a4az5/pQl
         G+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541464; x=1790146264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6n5rbrY/01roG/1TlDqdvk5Po6lB1Q7LrGFLCfNfZQw=;
        b=LmBE05wI8SFnwO68aUfnQPXiGBjPSuAZ+cFjoAm+tcWUlsnJjL0FKo3Qj123epX30E
         wk+XYDZ9rUvD2i3RY0CbFJQnZlntmUNykBH5k11t/dX/wPoMQpYuzGUMb/DlABas+/EE
         CntVDVF9rc3d9EjVkIomItXcwzOpaQ4/MmFWlFbNaNVpVcOl/0TMoWn4hTviXFzzjULn
         vdVYHA3YCltoaXqEUhf2tTtNlzkysIEAPdahXP8uQUQlY99u6DTQ1/UaBD3dVkSBPlwu
         Wy4BPYO2DqrDAi4dO7MJe4LCDHxJfZWv2GU+cygvy9uhFtJ8HCvwjSPXzsqcjDu0ik1p
         /bWQ==
X-Forwarded-Encrypted: i=1; AKwUvByLNFawXhB/umN3ubjMQOvonv4sAPZO1WBzTYTDbDbj7FLZ+yf2r+mLOk0DRVmELV2MxxcBgg==@lists.linux.dev
X-Gm-Message-State: AFuF++lUCnPtDpqfESpJYzSq7SYcpRdnFZM4cg/cFyvE/NQQ6Q12ySHr
	z8EWTlYUDyr2zm+ao4gW/vYGjKfkKlfJqGRv7RAcGsfguPjOk/iafl9GCmeUkKJKwWQbYiMnoew
	hqt4L8nAhtqBZnKceTKyuMUyturO7rjY=
X-Gm-Gg: AYBFou2E+7xGfXqYGKYYI68pOqtsPbMPd/6NCtiSFxqkKIeTCu/c6KVLtt7SzUMLi3y
	pCYeDZVwv45GrF0dbNQFFF1i2UMqH7mFiHwU8jlGZKwIpbeBzIkUJeJZqQ79YxJ11LPPJnw7EUk
	6NiyIouz+Iqm/oDxe+K4CPKnvePvLXNTmUSdhhUVo0NRluT6eDMAHZWm7tFuQ4BeImh26NM6xir
	dEgbHL2H6kQQyDCZobqOkNwCHD+M0b1HgCq+FqafnAwIk01oQyCZafLS7fkYVk9fyK5r08/So5e
	LvvMKG5aduJGHlfyyj285bIjIKi31T1E15xAdd1URvHfpEfJ7jAlK2mRMe9etS53qlNHvn8Voe/
	TgUeJncALmHebww==
X-Received: by 2002:a05:600c:4505:b0:49c:fc6e:a3e1 with SMTP id
 5b1f17b1804b1-49eb7346118mr12408175e9.32.1789541463728; Tue, 15 Sep 2026
 23:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260916041409.106926-1-sj@kernel.org>
In-Reply-To: <20260916041409.106926-1-sj@kernel.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 16 Sep 2026 14:50:52 +0800
X-Gm-Features: AcwNN1VhHl9-ceP5c4iG_sWBNprIthUHetKIW-a6tK-i7YoEH8Zpfkg8hmrI5R0
Message-ID: <CAN_Opa-Cb2TG0C1bZix7LqFk_LH-0qgNgkj8GU4kUE2FwtA7mQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/damon/core: don't skip damos_adjust_quota()
 while esz is not zero
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lianux.mm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:14=E2=80=AFPM SJ Park <sj@kernel.org> wrote:
>
> DAMOS could unexpectedly stop working when a user disables quota using
> the online parameters commit feature.  Fix it by correcting a wrong
> quota unset check in damos_adjust_quota().
>
> DAMON users could disable all quotas by unsetting time and size quotas,
> and removing all quota goals.  The intention of disabling quotas would
> be making DAMOS run at full speed.  When such quota disabled setup is
> detected, damos_adjust_quota() skips all its work.  The skipped works
> include effective size quota (damos_quota->esz) updates and charged
> quota amount (damos_quota->charged_sz) resets.  The intention is to
> avoid doing unnecessary work when quotas are disabled.
>
> However, users could do the setup while effective size quota is
> non-zero, by doing the disabling with the online DAMON parameters commit
> feature.  In this case, because the effective size quota exists, DAMOS
> will keep working with the quota until it is fully charged.  After the
> effective quota is fully charged, the charged quota amount
> (damos_quota->charged_sz) cannot be reset because damos_adjust_quota()
> skips it.  Then, DAMOS stops working until the quota is newly set or
> DAMON is entirely restarted.
>
> The problem happens because damos_adjust_quota() assumes the user setup
> for disabling quota immediately disabled it.  In reality, the quota is
> still working until the effective size quota is also updated to zero.
> Other logic for catching that uses damos_quota_is_set(), which
> understands the fact and therefore checks the effective size quota in
> addition to the user setup.  Fix the issue by using damos_quota_is_set()
> in damos_adjust_quota() to determine if its works should be skipped.
>
> The user impact is a non-deterministic and unexpected DAMOS stop
> behavior.  That is, users would disable quotas using the online
> parameters commit feature, expecting DAMOS will run at full speed.
> However, depending on the timing, the setup can be updated while the
> effective size quota is non-zero.  Due to the above mentioned internal
> mechanism, DAMOS stops working instead of running at full speed.  It is
> unexpected behavior.  It is also non-deterministic because sometimes the
> setup is done when the effective size quota is zero, depending on the
> timing.  It doesn't cause critical issues like crashes or leaks.  Users
> can simply set a reasonable quota again, or restart DAMON.  But
> definitely it is an unexpected and non-deterministic behavior that makes
> it difficult to reliably use.  Also investigating the root cause of the
> behavior would be quite difficult.
>
> Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
> Cc: <stable@vger.kernel.org> # 5.19.x
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Thanks, SJ. The commit message captures the full lifecycle precisely.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

> ---
> Changes from RFC
> - RFC: https://lore.kernel.org/20260912200814.145612-5-sj@kernel.org
> - Split out from the cleanup series for taking hotfix path.
> - Describe the real issue.
>
>  mm/damon/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e0414d2adcb41..89390897a0d8e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3330,7 +3330,7 @@ static void damos_adjust_quota(struct damon_ctx *c,=
 struct damos *s)
>         unsigned long cumulated_sz, cached_esz;
>         unsigned int score, max_score =3D 0;
>
> -       if (!quota->ms && !quota->sz && list_empty(&quota->goals))
> +       if (!damos_quota_is_set(quota))
>                 return;
>
>         /* First charge window */
>
> base-commit: 191c4a84eef1db85cc7e1a853761e8ce8683afd4
> --
> 2.47.3
