Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20BF5592E5
	for <damon@lists.linux.dev>; Wed, 23 Sep 2026 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182051; cv=pass; b=E8JgtnzvxYxmS325r8YAUh/l9HHx0AkvikerpAlVSvA6A+8bFAQCg0hyJgxqW5he4Zow2kpD5hzPFkja+r9NcYwxJLIFfbdsipfDLnZxnz0gXcPXDKpfpdi2Ch6dnXs0m+taiIJigbUVNoV9iNFQ9kUlRmNPl70xS9Lu07ZvP9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182051; c=relaxed/simple;
	bh=ZUu/E4ThfNs6/hpOHi+oCAKFDMTBtwuUpcdaOif5M+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwBqXTxcl3595DPJopB5QaaYnN21Ud9MeLlxdNKQLvonhnEfvtcDHdRjEyAhal2DoC6IB/kjNu+e/hOrfAPT0K+YtfiDAB02m7K23RhHR5zm1duaStyweW+87jwSzLOUoOOBFDFMQLvHfSY9FvK8dgM/8qumZ3Qf0+HbqcE7/os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ8dEHth; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ8dEHth"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1ca5b0d6so7993735e9.0
        for <damon@lists.linux.dev>; Wed, 23 Sep 2026 09:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790182039; cv=none;
        d=google.com; s=arc-20260327;
        b=QlxmXK9ehIt/My0Bu6SZeyackLYOwiqU/5ztg2ZU2RMDajA4Tpn0SsEyPUS2P0l6sg
         9O0pHBxg8uZpI7pomfDAJYUdHavrUX28MuPdOsVhKOEfJ9roBiH2J98MjXlNcg+/D2tg
         6zacqT+yhidBu6FoO9s5SHfKBzWb/nfSQ3NDpjYzB49Iq1xU4k9Sy7pVH2RbrJhN+0ZE
         UonXQ54LtPeZEhE3tkWxhv0DomBnZrQ7sVZyVolxMady8ueKAjyPmaFGwban2KERm/F0
         zNOF2yG5eXuPVogu4eue9VxLYg31irpSbKoJPSi+VcCK2s7njh7sCY/LkqK5k/RxnVzs
         Scug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tAQcvfsEw2NREatFJ5f2rKVMnBOJ07JjjvYvVs9Yqug=;
        fh=vDBakCW1gv+XKojX+pr7PmSiOhTuLUSRdEnIedJ2k3g=;
        b=POAKT3pkjG+M1kiQ2Ksr35mDWR563c10yjfhw9oNwDMiYTyUHMf0lfPg9pGy+OxsBy
         B8hMJ4Jwdq2i/2A4cAWuIq4c2ir9kMl7VyvFtT+8q60xEl3LcmVaWscHsKD3mv6vASkB
         oPoWiXorkjmB6gFQDdyZUShm6w3b/0UeT2Qb03GJYKejXc/UH6eBWg7puETmtZhx6j+K
         yRw6l4JFCF/yknB/TvsL11wZePc2IxLd/fCRVmjEjLEHBDatCmmJufUJS8aQA0P5rEp5
         ntDnbr/gs2QTJwUYH4gSry+XEVmH96GUf6GN9gDzh+3pYA/3xO3oLkkyhLyeJCJbELkz
         eDLw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790182039; x=1790786839; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tAQcvfsEw2NREatFJ5f2rKVMnBOJ07JjjvYvVs9Yqug=;
        b=HJ8dEHthcLLDPnpEBvxkmfUmQRliPPj1HCysxGIbcQUVosxCdsFsntduiPPgmsbM9n
         xWZuVPMDCBlV/nuANG1mWokLQr6DQubvFz3mccYP4CORLVESFhjYX/ddxw5Woo6DbY5U
         LOQ1Sk3mJ7jcB5lRpcdhGTXMdAT7LEsbzCOIHQEtpNg1v69XEIDZT4Yma4NniH/nzWo0
         2tBb3oURWxennOXo6PHoWzV/wc2eI/G9hAVccvRpvpkyXz96CVHC8mQDHBUch6bWnoS7
         H1Bqxjmr3TAWSSXCuezGIiq5f3Y6DI/5q+dtv+RQPKRLi3JDhr5CbgcZSr4Z6ScB9ZkA
         FcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182039; x=1790786839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tAQcvfsEw2NREatFJ5f2rKVMnBOJ07JjjvYvVs9Yqug=;
        b=gVzc8TVQbsBKi0pZ3f1Ekxb0KrQ/zkqx4ZmnAO6X/I2bGrKZBhvvI2OPIr9zT5jgl9
         JLAM6Q7rhwSDPeuqDDNdgFGR4+C4uK84vlb9U9tsMkGwgwGsOxX7Ol/7u5Uc2GH7yMh+
         JF2jVENh7e+grUHv9qa2TT+M1mL1LV019Lfs5PnwkVPbTNXwOVMCGn9kaJ694IAjLloH
         mq4+zoRBQj6edmvXxoGSLVCls7greVIN+5UxRFk2rwkcgAzAWhYyBnyIwFcBMcB0PW4u
         TU1QxogY5g48REMmRLWUN4zX7EEXZp2FoLpOrD0VB6Gats/icdRhGPWSgu8eJpBxhsYk
         mOGA==
X-Forwarded-Encrypted: i=1; AKwUvByM0atBKRFlrwbdXQTVnAZS5VIqrgUFKrK0jfrL+Bi0wkBO8dV0OL1c/15kXYLcJVFI4EK/Yw==@lists.linux.dev
X-Gm-Message-State: AFuF++nHdvEZFcZGIt7f6oeftroUmQyKQsr8DLnzh8fPW3cgKGnA1v9S
	vDWEFYLw5Zt/4dPGUD8l4MLsSsJdg70HlOYGX5sLLfbLRDOURTBkVpPI1925IVZsIp3CcIRQy9B
	6b7cURHOi+IO1+RFDwP8QL9G+S4iPaNE=
X-Gm-Gg: AYBFou0gv0mlPrroFrmueNblV3EYsZ84n38el3F6GkllmUZSn3KjpM2iW+DibcMAWZk
	MGHckMYsrtve2RVBec95IShMNoix58wUaLYICDwpauJhJueKZztGMLK6T7RXEIzqmaTWtkHSM7M
	oo3nYfACMxmttVRplqsr3RvdNOjNevGKZX3kTMNQZ3rtDStdXS26b3taQ5yGMAx70aKHVo3TqQo
	W1pZ1xxqED0z7jx/wWH0yXKORzeyEjs/alcDZNhpgrhOPFYCaNiHmDLW6G7J5+0VWvGVhaes724
	6SmuzfNJNx1yG9rePOCfnAt5x3sVDBf/GgdAAtxbBaiC1ic3/9m3XlCutNvEQhmAXS8uTcsga2s
	Jcgi722hgLstY0A==
X-Received: by 2002:a05:600c:4e93:b0:49c:e27c:6b10 with SMTP id
 5b1f17b1804b1-49fdee0a952mr49666665e9.3.1790182038728; Wed, 23 Sep 2026
 09:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260923055139.2982-1-sj@kernel.org>
In-Reply-To: <20260923055139.2982-1-sj@kernel.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 24 Sep 2026 00:47:02 +0800
X-Gm-Features: AclHuK-q8bibuGsWXEsNmxKAcN1nnzvypJ4ztbgQ6XSyFRq2oe6A825P900qgHo
Message-ID: <CAN_Opa_d=Dta4hRcvXuyi0wj+uoOgLxOCuHU3K4d9o34e_Aypg@mail.gmail.com>
Subject: Re: [PATCH v3 mm-unstable] mm/damon/core: keep the temporal tuner
 quota over an unmeasured PSI round
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Karl Mehltretter <kmehltretter@gmail.com>, 
	stable@vger.kernel.org, Lian Wang <lianux.mm@gmail.com>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the update.

I also checked the issue I raised on v1 regarding unmeasured rounds.
The temporal case now uses the effective quota to determine
current_value when there is no previous PSI sample, while measured
rounds continue to use the PSI delta and update last_psi_total.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

On Wed, Sep 23, 2026 at 1:51=E2=80=AFPM SJ Park <sj@kernel.org> wrote:
>
> From: Karl Mehltretter <kmehltretter@gmail.com>
>
> The patch in mm-unstable of subject "mm/damon/core: handle uninitialized
> damos_quota_goal->last_psi_total" scores a PSI quota goal without a
> previous sample as achieved. This leaves the consist tuner's input
> unchanged, but the temporal tuner sets its quota to zero for an achieved
> goal. A running scheme with a nonzero temporal quota therefore loses a
> charge window after a quota-goal commit.
>
> Use the effective quota to preserve the temporal tuner's previous
> goal-achievement state during an unmeasured round, as SJ suggested [1].
> Score the goal as achieved when the effective quota is zero and as not
> achieved otherwise. A new scheme's initially zero quota stays zero, and
> the consist tuner's behavior is unchanged.
>
> Move the PSI current-value calculation and last_psi_total update into a
> helper that takes the current PSI total. This lets a unit test cover the
> unmeasured and measured rounds without depending on system memory
> pressure.
>
> Link: https://lore.kernel.org/damon/20260916001311.101024-1-sj@kernel.org=
/ [1]
> Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goa=
l")
> Cc: <stable@vger.kernel.org> # 6.9.x
> Cc: Lian Wang <lianux.mm@gmail.com>
> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> Suggested-by: SJ Park <sj@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
> This is a fixup of a patch [1] that is still in mm-unstable tree.
>
> [1] https://lore.kernel.org/20260902002725.108635-3-sj@kernel.org
>
> Changes from v2
> - v2: https://lore.kernel.org/20260921020013.33105-1-kmehltretter@gmail.c=
om
> - Split out of the series for squashing into the broken patch.
> - Collect R-b: from SJ.
> - Update commit message to make clear this is a fixup of a patch in
>   mm-unstable.
> Changes since v1
>  - v1: https://lore.kernel.org/20260915060937.3423-1-kmehltretter@gmail.c=
om/
>  - Use the previous effective quota for the temporal decision, including
>    when it is zero. Keep resetting last_psi_total for new and updated
>    goals.
>  - Move the current-value calculation and last_psi_total update into a
>    helper. Test both tuners with explicit samples and check
>    last_psi_total after each call.
>
>  mm/damon/core.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 4687b909d42c..733025b36745 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2956,6 +2956,28 @@ static inline u64 damos_get_some_mem_psi_total(voi=
d)
>
>  #endif /* CONFIG_PSI */
>
> +static void damos_set_psi_current_val(u64 now_psi_total,
> +               struct damos_quota_goal *goal, struct damos *s)
> +{
> +       u64 last_psi_total =3D goal->last_psi_total;
> +
> +       goal->last_psi_total =3D now_psi_total;
> +       if (last_psi_total !=3D U64_MAX) {
> +               goal->current_value =3D now_psi_total - last_psi_total;
> +               return;
> +       }
> +       /* uninitialized last_psi_total; make no effect this round */
> +       if (s->quota.goal_tuner =3D=3D DAMOS_QUOTA_GOAL_TUNER_CONSIST) {
> +               goal->current_value =3D goal->target_value;
> +               return;
> +       }
> +       /* let temporal tuner show the same achievement as in the last ro=
und */
> +       if (!s->quota.esz)
> +               goal->current_value =3D goal->target_value;
> +       else
> +               goal->current_value =3D 0;
> +}
> +
>  #ifdef CONFIG_NUMA
>  static bool invalid_mem_node(int nid)
>  {
> @@ -3208,13 +3230,7 @@ static void damos_set_quota_goal_current_value(str=
uct damon_ctx *c,
>                 break;
>         case DAMOS_QUOTA_SOME_MEM_PSI_US:
>                 now_psi_total =3D damos_get_some_mem_psi_total();
> -               /* uninitialized last_psi_total; make no effect this roun=
d */
> -               if (goal->last_psi_total =3D=3D U64_MAX)
> -                       goal->current_value =3D goal->target_value;
> -               else
> -                       goal->current_value =3D now_psi_total -
> -                               goal->last_psi_total;
> -               goal->last_psi_total =3D now_psi_total;
> +               damos_set_psi_current_val(now_psi_total, goal, s);
>                 break;
>         case DAMOS_QUOTA_NODE_MEM_USED_BP:
>         case DAMOS_QUOTA_NODE_MEM_FREE_BP:
>
> base-commit: 4b811cf44e3dd87981f18631be832027385f7d4f
> --
> 2.47.3
