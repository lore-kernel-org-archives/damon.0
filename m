Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC1221264
	for <damon@lists.linux.dev>; Fri, 12 Dec 2025 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765545618; cv=none; b=t9asyVcNaCJziHPgBO83g3DYBVOkQt/32qXT/D/Ye52vFclsjdiKgxqNHt3UC6cXl0rrpT7RFcXA2FDKOkPxyz/rHOiSxoeAQNxN8y7UQtShbC3bI9wErMzVEzExHQ9q6Ur3/sxagTAHgC53aSze57q2S3wipozrj8y4arygz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765545618; c=relaxed/simple;
	bh=5u3wVqxj1mI9rZxHw+pImxHlSdOhn6Lr/LtN7hHR2Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQO12smKyiGuLsNgV0U3xAT3Wwipht7Zg1Wb9ABKUKJ4jnhO4tUetkhk5VYR7EzPhFRacJp8l4DcdrVEKe0G9SJZfRaxHh6mtDVMU18DpQfnozhccxWcX05/5PVAacqzbzTNqAHsSKx0WR7OWuvb8H2dwunfgjjS/W6o5XUQ0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNhAs+uO; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNhAs+uO"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6446c2bbfe3so1171250d50.1
        for <damon@lists.linux.dev>; Fri, 12 Dec 2025 05:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765545615; x=1766150415; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gzHnejj8FlvJoZPTI0Iwe9LyfECd4OIzjxmqM5a/Z6Y=;
        b=WNhAs+uO6Jj8W/posh2yttutXuaSj9FtB6FmFIsgCEptzVssZ7l5c9cxxGE8vin2eN
         CL2CUxugHqE/83bbDy//oV56eqberDcBYLV04ZHRe3wmYXbL483o2bkoh2GV41/OKsRE
         H5xpgugRhAK+Cr4ZdDf4v4AM3Quat1oly3CjnBO7xbfhElbg8b2kpkwsZtYZApw8KsRj
         vDPhSZKjJD/docoVs/7kwj2f+R/5hcum7vuHbfyrVmMlRyhdMR677KYwFYUC5pBDoKuh
         uTkg8QdS7bWuvWTovZ8BR1c4Fn6MKm1LdahqWYiteSR5GvX57e25k9XxhIt/4L8QGahJ
         VT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765545615; x=1766150415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzHnejj8FlvJoZPTI0Iwe9LyfECd4OIzjxmqM5a/Z6Y=;
        b=m+HrUcaKO1t+k8MeOKxJs6fcTHSfsls9Je9ki3bRqLFmgk13cWKasK4W9MJTOW2WsU
         DzfRHF+0A0sfBZtKRoLrByZ3N40F3BkdiqHZYQbFOzP8qVZInpeZuJsphFvUrqnx97ad
         CamF636VIojCYIiApbUHOe5m0aLc6MVfGdhSr6Kwpf8llfFIx0xIDrHB6jAG5malUHaR
         BGDNH6l3uhHRkoN6ah3fncOeCW5+FdmZOYc+asqz2zpp/a+GcKiQRPCo4KASSwgmAu0a
         lt5CFeKb59o9MEAnzzor5ANk1P7rsogWTNZGnw8kv1oCPPimJ13DsgLE9AU5HDHGngK2
         8FBg==
X-Forwarded-Encrypted: i=1; AJvYcCXZyK8QoB1lTuuCZGG2Flw0/ZJuN9MLC1z9GCFrhOuywtHPT+4OlZWIPrfP9TMfZuEX29M8GA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8in3xfrq1WnRC1GzcFQvoUZ4ffsrTXp8GPPtdHpMss4gOATjR
	PrpCEwU+aglkU0SOT9LobuJYJqdQ1P69Y4kuBzdmsjRHBciU9lw33zLE5M9VxaqI7P+QyajUwbT
	9Fhd1MQiMnOyfw3ZKuxHr0eeN7utBO24sXjDCE08=
X-Gm-Gg: AY/fxX6rOny6NK85GjHxlAooCTfQrqRgBuDRFiAdbNvioSJC8ydwIQf9duba8/x/4pU
	IcjTUwRCfGxExjH1KGNTuq+lxl8ym2UPsUDiEDtYaX2W9RxLDAsoo5+8qyI4lQQ1h0vSgkckT20
	kxbYgrRQrvgIKbSWB5r95yOEPGouZrTrPSjYBVoxtBuAjpjZT5zlKcuPkhuvXNYXzp2PkUUOXul
	goCqgPVMVqDC7mu2VcA17v9jnItEKh772/q9SVcVDdCK9/QNfj9fK1+rDU3uKrCxrYBmrJflVY3
	oph9Y0g=
X-Google-Smtp-Source: AGHT+IHnkwapZuSfPrtWGxGZpc4G+TYqUmEglUfs7oJm1L366fuFdiHWGE/dajxKNzADDxbDcuoHYHvJHC5Sy26zlx4=
X-Received: by 2002:a05:690e:13c2:b0:640:d31d:6ed4 with SMTP id
 956f58d0204a3-6455564ef81mr1316411d50.51.1765545615251; Fri, 12 Dec 2025
 05:20:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251208062943.68824-1-sj@kernel.org> <20251208062943.68824-8-sj@kernel.org>
In-Reply-To: <20251208062943.68824-8-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Fri, 12 Dec 2025 22:20:04 +0900
X-Gm-Features: AQt7F2rwF43VTf84s_zacyLJLnB4XlNKOig3wI6N8NrIFP5vpH9CYdsAr_9HKVc
Message-ID: <CAHOvCC4WQPo5HrCJ+958t1ab2NDzbg493XYarqACARTpYskVzQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/37] mm/damon/core: apply access reports to high
 level snapshot
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Dec 2025 at 15:35, SeongJae Park <sj@kernel.org> wrote:
>
> Now any DAMON API callers can report their observed access information.
> The DAMON core layer is just ignoring those, though.  Update the core to
> use the reported information at building the high level access pattern
> snapshot.

It seems inefficient to repeatedly access the damon_access_reports[1000] array
using a for loop in the kdamond_check_reported_accesses() function.
It is inefficient to for loop through the entire
damon_access_reports[1000] array.
When CONFIG_HZ and jiffies are increased as follows and
damond sample_interval is 5000us (5ms), the time flow diagram is as follows.

CONFIG_HZ 1000, jiffies == 1ms
damond sample_interval == 5000us (5ms)

reports_len(==): [0 ... 5]
                                                     [*]
        0       1       2       3        4       5     6    7    8
9     997  998  999
        [====|====|====|====|====]-----|----|----|----|  ....  |------|-------|
jiffies++    1        2       3       4        5     0    0    0   0
    0      0       0
damond_fn(sample interval)      -5[0<]

reports_len(==): [997 ... 2]
                                  [*]
        0           1            2    3    4    5    6    7    8   9
    997    998   999
        [======|======]----|----|----|-----|----|----|----|  ....  [=====|=====]
jiffies++   1001       1002   3   4   5    6     7    8    9       997
  998    999
damond_fn(sample interval)
                            -5[997<]

It seems that only the section corresponding to the sample interval ([==|==])
can be cycled as follows.  And, how about enjoying damon_access_reports[1000]
as damon_access_reports[500]?  Even if it reduce the 1000ms to 500ms
array space, it seems that it can sufficiently report and process within
the sample interval of 5ms.

 static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
 {
-       int i;
+       int i = damon_access_reports_len;
+       unsigned int nr = 0;
        struct damon_access_report *report;
        struct damon_target *t;

@@ -2904,16 +2905,18 @@ static unsigned int
kdamond_check_reported_accesses(struct damon_ctx *ctx)
                return 0;

        mutex_lock(&damon_access_reports_lock);
-       for (i = 0; i < damon_access_reports_len; i++) {
-               report = &damon_access_reports[i];
-               if (time_before(report->report_jiffies,
-                                       jiffies -
-                                       usecs_to_jiffies(
-                                               ctx->attrs.sample_interval)))
-                       continue;
+       report = &damon_access_reports[i];
+       while (time_after(report->report_jiffies,
+               jiffies - usecs_to_jiffies(ctx->attrs.sample_interval))) {
                damon_for_each_target(t, ctx)
                        kdamond_apply_access_report(report, t, ctx);
+               if (++nr >= DAMON_ACCESS_REPORTS_CAP)
+                       break;
+
+               i = (i == 0) ? (DAMON_ACCESS_REPORTS_CAP - 1) : (i - 1);
+               report = &damon_access_reports[i];
        }
+
        mutex_unlock(&damon_access_reports_lock);
        /* For nr_accesses_bp, absence of access should also be reported. */
        return kdamond_apply_zero_access_report(ctx);
}

Thanks,
JaeJoon

>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h |  1 +
>  mm/damon/core.c       | 68 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index b8ebb2aa02c8..b04c2e36833a 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -83,6 +83,7 @@ struct damon_region {
>         unsigned int age;
>  /* private: Internal value for age calculation. */
>         unsigned int last_nr_accesses;
> +       bool access_reported;
>  };
>
>  /**
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 296117d5e7f7..a14754a47c7f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -137,6 +137,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
>
>         region->age = 0;
>         region->last_nr_accesses = 0;
> +       region->access_reported = false;
>
>         return region;
>  }
> @@ -2745,6 +2746,68 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
>         }
>  }
>
> +static void kdamond_apply_access_report(struct damon_access_report *report,
> +               struct damon_target *t, struct damon_ctx *ctx)
> +{
> +       struct damon_region *r;
> +
> +       /* todo: make search faster, e.g., binary search? */
> +       damon_for_each_region(r, t) {
> +               if (report->addr < r->ar.start)
> +                       continue;
> +               if (r->ar.end < report->addr + report->size)
> +                       continue;
> +               if (!r->access_reported)
> +                       damon_update_region_access_rate(r, true, &ctx->attrs);
> +               r->access_reported = true;
> +       }
> +}
> +
> +static unsigned int kdamond_apply_zero_access_report(struct damon_ctx *ctx)
> +{
> +       struct damon_target *t;
> +       struct damon_region *r;
> +       unsigned int max_nr_accesses = 0;
> +
> +       damon_for_each_target(t, ctx) {
> +               damon_for_each_region(r, t) {
> +                       if (r->access_reported)
> +                               r->access_reported = false;
> +                       else
> +                               damon_update_region_access_rate(r, false,
> +                                               &ctx->attrs);
> +                       max_nr_accesses = max(max_nr_accesses, r->nr_accesses);
> +               }
> +       }
> +       return max_nr_accesses;
> +}
> +
> +static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
> +{
> +       int i;
> +       struct damon_access_report *report;
> +       struct damon_target *t;
> +
> +       /* currently damon_access_report supports only physical address */
> +       if (damon_target_has_pid(ctx))
> +               return 0;
> +
> +       mutex_lock(&damon_access_reports_lock);
> +       for (i = 0; i < damon_access_reports_len; i++) {
> +               report = &damon_access_reports[i];
> +               if (time_before(report->report_jiffies,
> +                                       jiffies -
> +                                       usecs_to_jiffies(
> +                                               ctx->attrs.sample_interval)))
> +                       continue;
> +               damon_for_each_target(t, ctx)
> +                       kdamond_apply_access_report(report, t, ctx);
> +       }
> +       mutex_unlock(&damon_access_reports_lock);
> +       /* For nr_accesses_bp, absence of access should also be reported. */
> +       return kdamond_apply_zero_access_report(ctx);
> +}
> +
>  /*
>   * The monitoring daemon that runs as a kernel thread
>   */
> @@ -2790,7 +2853,10 @@ static int kdamond_fn(void *data)
>                 kdamond_usleep(sample_interval);
>                 ctx->passed_sample_intervals++;
>
> -               if (ctx->ops.check_accesses)
> +               /* todo: make these non-exclusive */
> +               if (ctx->sample_control.primitives_enabled.page_fault)
> +                       max_nr_accesses = kdamond_check_reported_accesses(ctx);
> +               else if (ctx->ops.check_accesses)
>                         max_nr_accesses = ctx->ops.check_accesses(ctx);
>
>                 if (ctx->passed_sample_intervals >= next_aggregation_sis)
> --
> 2.47.3
>
