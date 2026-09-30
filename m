Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD99313543
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762423; cv=none; b=JHQCDG7R7HgB4xU0CwsL4jTphWaH+KhXdCHrQT5WlALP44exe4mbr7qQLt9E75qLjohZoM/JCeNFBl1wDE9zD1qsJpTJcoNlj3avV7KMO3Cb3xGNlGEKwIBwyHHB8KBdhpFoH+Q7yV3pIcusPT632lJTaBBIoYMrwa3S1L3lFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762423; c=relaxed/simple;
	bh=R5Ggegap4roC8LXjigxfjYdvZpgYT6sKtevqgYVu/IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gf4A79czBW4MoxKBHo0++9W1itBX0ighfieewcaRIAJ1rnySTVOcBH0fMMjZy+wBcg2P5hbLsaK2BI5bK8nxUlWPsTAv7ncFQLSVrDqAsFztf/jkNkshrOIYdRd6UUtthxXN5jj8tslU4xJxim4gQQDWnkSRrVHeqCbLw+aisOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNfguRr3; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNfguRr3"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ec6188so24798225ad.3
        for <damon@lists.linux.dev>; Wed, 30 Sep 2026 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790762420; x=1791367220; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uY42P4Ky+ruFRmU+eZJWwX/D5fQMOFLbNxI4/lZCJAg=;
        b=ZNfguRr3ripyCfiy5zI/gdHQbTuvOroQyGouIkYTmRfkFYDJuNYbaInIP41ajYAjtj
         V8IeFHXw5iJU4hTLXBBvZkIp1dmfRM7wGaGrer8xYoInVjaNhEtpZ1jgumktNHbIb2sZ
         IDRAB2SF59GzOiBPen0ggXBTpAsNlDUlUB1a7QQQA6Lm8rQ0GsD520bGUgqMJAHABZPh
         E0Ixn33+06kbpxTglOPkB4g+RR4H+NQ5bU0kM7xw/H+hEMnJJXO70S3ahQks+nqwctC3
         dZr0INFafpVmRJTSNhO5qilOTmzoBHOG3eiO608jmBoy9FFv/IHsiQrWHYJBEYa/dGfs
         cysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790762420; x=1791367220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uY42P4Ky+ruFRmU+eZJWwX/D5fQMOFLbNxI4/lZCJAg=;
        b=oP/eqBooIPs2KPGTcK6gJG56serH/su8m4n8gvYedodGu6uXJK51tzdEaAWfoKHwEX
         pZ1vs4FUbQPaMUn8MDC9Ubg2Al4ZNgGpjnlDwqc49wgJld0nzJAUv8gd8bFHc+0IQJP0
         04GIhcJakcXMtcliEZfEayz/wGfQSxr0xFn+Sf0LfHFe8kVtOeZOOUIUCAHlqxBLWFbg
         mjX7XHWrnnrRBuN2tt2al7qb3dkF8C8oV9biLpY+ovPqr7buy+pCimraYYxjwtP5ZKuO
         pJpymQyq+mvnPgfm0YEO2mpscdDT5gLKLPyMJcES/io8xhu9jzuLTNwn1VgFJDjLw2J1
         cdUg==
X-Forwarded-Encrypted: i=1; AKwUvBwi/mKpH7qRXbTN5hQCxjJIUs3vhBtCx9yanZi5XXTKa2Clwa69z8SqDmpIVD3dz+IFD2azxg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJdyWo1eLDsF2LvfavizOQLIvJ5X8feZqyP6dONak366MaalJgH
	k2k4lJIatG3bGHOQ4igeb+nu4Sh6kb2+aujlBAmRZjAp9JopHOpzvaeZbdcVmQ==
X-Gm-Gg: AYBFou29OvktBzIPtFl8miEdLK0n1wfnItrwLUg8K/HjiTIuFM3bfCx4ssBz0priBqI
	chMjZW8/jO/XfuY2fp5PMB9ynSfUkPk6aP5wuRXAVULnjLA9Mrhuxg8YUIsIIwtDskuRyfEEpMF
	dIiAzrNqvrrh6x/EwQGPdCs/7+twRqdDUd7TzfMAQ+THKa7dWKuiOeP+W5ynoUdtuAxYdoAkNw6
	wMj6lc9d+iBgF6eUF8urdxf+ns38PsmLC/4QzKpDgAOQz3u4SF+PEqLOe0iqvlTzrQ3Y5bakMn9
	yT6t7QRGvgFC2QLGF43NJDIyNYQrNwFA+wSxAVNoookzO6FDeEVuYu6DwT/NnVc2Yc3JsF5cki3
	SGvMpHzGb3C5aG5AtJjVwdy/zud5QcmXXkIf2j+G7oAf8D4VuhaY7RsW9XsQLyhYljfFn6xsxkF
	pqEli6FpyOK8+GdOuAzOfW+nd/wd54vbIkuNJoOvpWxZmcIhixnhD53cTEgH5eqggS+S2qTUoJS
	v+6ghTwmWemuA2YuROHD1Mt
X-Received: by 2002:a17:902:d54f:b0:2dd:c100:4248 with SMTP id d9443c01a7336-2e2e4b7d4bbmr8415345ad.44.1790762420172;
        Wed, 30 Sep 2026 03:00:20 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:867:387a:70b:38f1:a1dd:9303])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5c32c66sm4583335ad.74.2026.09.30.03.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 03:00:19 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC] mm/damon/damo: saving damon sysfs configuration
Date: Wed, 30 Sep 2026 17:58:54 +0800
Message-ID: <20260930100031.7338-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929074300.40012-1-sj@kernel.org>
References: <20260929074300.40012-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026 00:43:00 -0700 SJ Park <sj@kernel.org> wrote:

> Hi Liew,
> 
> On Tue, 29 Sep 2026 03:13:06 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Hi SJ and Community,
> > 
> > I've noticed that damo [1] doesn't seem to have a feature for saving
> > DAMON SYSFS configuration.  I tried 'damo args damon', but it doesn't
> > save the DAMOS schemes information.
> 
> If so, it is a bug.  Could you share more details including how the issue can
> be reproduced?  Directly sending a PR should also be fine.

Yes, this can be reproduced easily.

    # make sure DAMON is started
    $ sudo ./damo args damon > damo_args_damon.json
    $ sudo ./damo report damon --json > damo_report_damon.json

    $ sudo ./damo stop

    $ sudo ./damo start --kdamonds damo_args_damon.json
    $ sudo ./damo report damon --json > damo_report_damon_after.json

    $ diff damo_report_damon.json damo_report_damon_after.json
    4c4
    <         "pid": "4959",
    ---
    >         "pid": "5582",
    16,17c16,17
    <                                 "start": "4,294,967,296",
    <                                 "end": "15,807,283,199"
    ---
    >                                 "start": "4,096",
    >                                 "end": "15,807,283,200"
    25c25
    <                     "ops_update_us": "1 m",
    ---
    >                     "ops_update_us": "1 s",
    46,159c46
    <                 "schemes": [
    <                     {
    <                         "action": "pageout",
    <                         "dests": [],
    <                         "access_pattern": {
    <                             "sz_bytes": {
    <                                 "min": "4.000 KiB",
    <                                 "max": "max"
    <                             },
    <                             "nr_accesses": {
    <                                 "min": "0 samples",
    <                                 "max": "0 samples"
    <                             },
    <                             "age": {
    <                                 "min": "60,000 aggr_intervals",
    <                                 "max": "18,446,744,073,709,551,615 aggr_intervals"
    <                             }
    <                         },
    <                         "apply_interval_us": "0 ns",
    <                         "quotas": {
    <                             "time_ms": "0 ns",
    <                             "sz_bytes": "16.000 MiB",
    <                             "reset_interval_ms": "1 s",
    <                             "fail_charge_num": "0",
    <                             "fail_charge_denom": "0",
    <                             "goals": [
    <                                 {
    <                                     "metric": "user_input",
    <                                     "nid": "0",
    <                                     "memcg_path": "",
    <                                     "target_value": "3,000",
    <                                     "current_value": "7,855"
    <                                 }
    <                             ],
    <                             "goal_tuner": "temporal\n",
    <                             "effective_sz_bytes": "0 B",
    <                             "weights": {
    <                                 "sz_permil": "0 %",
    <                                 "nr_accesses_permil": "0 %",
    <                                 "age_permil": "0 %"
    <                             }
    <                         },
    <                         "watermarks": {
    <                             "metric": "none",
    <                             "interval_us": "0 ns",
    <                             "high_permil": "0 %",
    <                             "mid_permil": "0 %",
    <                             "low_permil": "0 %"
    <                         },
    <                         "filters": [],
    <                         "stats": {
    <                             "nr_tried": "0",
    <                             "sz_tried": "0 B",
    <                             "nr_applied": "0",
    <                             "sz_applied": "0 B",
    <                             "sz_ops_filter_passed": "0 B",
    <                             "qt_exceeds": "19",
    <                             "nr_snapshots": "0",
    <                             "max_nr_snapshots": "0"
    <                         }
    <                     },
    <                     {
    <                         "action": "stat",
    <                         "dests": [],
    <                         "access_pattern": {
    <                             "sz_bytes": {
    <                                 "min": "0 B",
    <                                 "max": "max"
    <                             },
    <                             "nr_accesses": {
    <                                 "min": "0 samples",
    <                                 "max": "18,446,744,073,709,551,615 samples"
    <                             },
    <                             "age": {
    <                                 "min": "0 aggr_intervals",
    <                                 "max": "18,446,744,073,709,551,615 aggr_intervals"
    <                             }
    <                         },
    <                         "apply_interval_us": "0 ns",
    <                         "quotas": {
    <                             "time_ms": "0 ns",
    <                             "sz_bytes": "0 B",
    <                             "reset_interval_ms": "0 ns",
    <                             "fail_charge_num": "0",
    <                             "fail_charge_denom": "0",
    <                             "goals": [],
    <                             "goal_tuner": "consist\n",
    <                             "effective_sz_bytes": "0 B",
    <                             "weights": {
    <                                 "sz_permil": "0 %",
    <                                 "nr_accesses_permil": "0 %",
    <                                 "age_permil": "0 %"
    <                             }
    <                         },
    <                         "watermarks": {
    <                             "metric": "none",
    <                             "interval_us": "0 ns",
    <                             "high_permil": "0 %",
    <                             "mid_permil": "0 %",
    <                             "low_permil": "0 %"
    <                         },
    <                         "filters": [],
    <                         "stats": {
    <                             "nr_tried": "2,000",
    <                             "sz_tried": "1.801 TiB",
    <                             "nr_applied": "0",
    <                             "sz_applied": "0 B",
    <                             "sz_ops_filter_passed": "0 B",
    <                             "qt_exceeds": "0",
    <                             "nr_snapshots": "172",
    <                             "max_nr_snapshots": "0"
    <                         }
    <                     }
    <                 ]
    ---
    >                 "schemes": []

> 
> > 'damo report damon --json' provides
> > more detailed information, but its output cannot be read by 'damo start
> > --kdamonds'.
> 
> Maybe this is also an issue that we could fix.

In my opinion, this is not an issue, since there's no documentation
recommending we use the 'damo report damon --json' to generate
configuration for 'damo start --kdamonds'.

> 
> > 
> > I'd like to know if there is currently any way in damo to save the DAMON
> > SYSFS configuration that can be correctly read by 'damo start
> > --kdamonds'.  If not, would it be worth adding one?
> 
> I believe it would be useful.  Please feel free to send a PR.
> 
> Nonetheless, we added the json/yaml kdamonds config support mainly because
> there was no good way to flexibly configure kdamonds with the command line
> interface.  Now it is much more improved [1].

Thank you for clarifying this!

> 
> I'd recommend using the command line interface.  That is, you could copy your
> command line setup in a bash script and modify/reuse it.
> 
> Is there a use case that it cannot work or suboptimum?

No, CLI (Command Line Interface) do very convenience.  I can write my
configuration in CLI and it is very readable.  Thank you for letting me
know this feature!

    #!/bin/bash

    # update-damon-config.sh

    ./damo args damon \
    --kdamond --damon_ctx --ops paddr \
        --monitoring_intervals 5000 100000 1000000 \
        --damon_target --regions 4294967296-15807283199 \
        --damos_scheme --damos_action pageout \
            --damos_sz_region 4096 18446744073709551615 \
            --damos_access_rate 0 0 \
            --damos_age 600000000 18446744073709551615 \
            --damos_quota_goal user_input 3000 10000 \
            --damos_quota_goal_tuner temporal \
            --damos_quota_interval 1000 \
            --damos_quota_time 0 \
            --damos_quota_space 16777216 \
            --damos_quota_weights 0 0 0 \
    > config.json

> 
> [1] https://github.com/damonitor/damo/issues/3#issuecomment-5655965736

[...]

Best regards,
Rui Yan
