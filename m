Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A844781C
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461356; cv=none; b=LiocehK+g82YEiOy9Db8TGlEfJfpYp1csUFW1pkHwfK1FTu9kaVaSaQDRyGxKDRaSAKti0TAWpnbh6brQEV+hP+62kaCiUxPMsw9BAjASMKHfpv1l/NAdxoT1HB+9DTkmlvclsfhcQfrpx+oUqspfmcJqCG9gF1flFnj8LD8Q34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461356; c=relaxed/simple;
	bh=5nCxe+s01cQSc0FMk77YlswAWLgbdRpR2K09nC3uzrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeEy/n0Vodrx9WP8oGZAPcQRFJTVbU2vCmHkykLMZkrsSz0ojaLjKtQo8nlRq88gmJETc2LoKuzSB+IofdSAF+CqZvS/ZWSTkFRl7Pu5ZdIyBG/SNnpf9Vc19WBoX705rQKsbX6CbE0N1BaOSrSoV5Rf+bTarE17EB+Y4J2duw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EICEBRak; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EICEBRak"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so1736018a12.0
        for <damon@lists.linux.dev>; Thu, 08 Oct 2026 05:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791461354; x=1792066154; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZpMs8OejlQaJGDNhMC4YaKq4cxnZ0droSQ5wJkH/ueU=;
        b=EICEBRak9S1y3lwko8u77GrpMCQXXKyseAFuY3x0K7TPSpbmbJj2hHaKcoAPEYiUTs
         P6dxWoPYu+E1vwDvUKmYNYQHecsxdyEd+mUtoC09cWsi80CP1Fjht6ozSAHl8POOsxld
         LPms2Gq/HCIR/znrVCmitw9WlRNSwajnIqumovevRwMQlrvV6czqP16sgAOCQSDPEmo7
         3V5T1cGOhEW4TDuIDBpD+WObvjF1g6kyOIj5t/H81IlBWjiYl541FffGJo18Rnx6ZW6M
         HGuEagzGxmzKSu9n7z5vin/DvKJ3xBR28c1h56X/c+npew9w138qm9+6kOhAGeS1jNcq
         +HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791461354; x=1792066154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZpMs8OejlQaJGDNhMC4YaKq4cxnZ0droSQ5wJkH/ueU=;
        b=ETJIZA1q3KPtilKu3unP0VOBhhRObBTUw+VQndu+K0xs15deDkDA+XzqVm+1xPAKTG
         qeu4peYIuOOiGvbTR1Af3z8ChsQYVtPC8CEC9F/uPIqt1eUkw17sFCbIk/4HoVmLLU3e
         jONwxoq83BSpDT3fYxrY4wZdxOND7WI6WFBkP1MbB0Cf7B1/wcdr4Yqs99EA/iYgfft6
         UNEseB5Y+MGZS6x7hkgWgdKgTSHC7PXF+LkkV0ylQ7tzbsib0r/e99HCxw2ZDjy173Ou
         1D7VJXwmrw2tEJ7nZKKJ2hWBLIP+dsuCLEQFeddxFez6Evh5CQiseF1DU1RnEGPXaVUo
         GHag==
X-Gm-Message-State: AFuF++m0DyqJyRLhDVI/wgi9j6cty0RNPPGiW9VfHj+Q69E3wPuLevaP
	c/sYe3/+Xim+qSvAIcL49CJKUf/Ce34N4W93DpQ/QcQgMEwRUahASrhj
X-Gm-Gg: AYBFou275gCb9a+fr96U82EK/qdUfAPgGghZiPONv9yMkSiieD9JRcERXg0NfkGq1Zz
	VoJB+215FnGg4v8ysl0ZAuVsCpZyEPb+sDHqRtNYnuM+VSi1b9gM8NLDvzE9hvaC19p+QL9WAgm
	sdnzemp/JsF+J3qFsPmc2VJ07v0ikgtQ3TnqdzcHf5Zj6x8jsxhqMfmwgEXSIjxsFpRbDKS+bv2
	CGPpFDTM78UIZImJlFGaPymVZajKSUMmq73Q/z3UypwzNVOYr6UnRHlMaoki2b6gkC2WKkKqVAG
	9LaTKtOyk0K35xurXDiJePWbM2Kh+omFTne1oq5CfCetNDQ//+fyD7QOhNLaiXi2W7gWc9GNfeD
	ZD12NMKeRbjj2d7uIScWGp/uffKw1Z5SspfND079K52oc7lrM+U2nLthjv94Uml0hPH6ihMCVgD
	+mvl/Rx6wC6IFf0GezcUU3V5AxA/WpVIn/5e7YgHYy2G+3KsKYUcyFitfHJm2d5w9FU59yUxvML
	rE0k31Zv8VxRgQarY0E/w63n2r1C/rr2unv
X-Received: by 2002:a05:6a21:6e84:b0:3de:5a86:9dca with SMTP id adf61e73a8af0-3e13401e966mr4271507637.19.1791461354483;
        Thu, 08 Oct 2026 05:09:14 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2001:d08:1334:29ed:db11:2c4c:ee4f:606])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bb2a5440sm1480111b3a.31.2026.10.08.05.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:09:14 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	SJ Park <sj@kernel.org>
Subject: Re: [RFC] mm/damon/damo: saving damon sysfs configuration
Date: Thu,  8 Oct 2026 20:09:05 +0800
Message-ID: <20261008120916.4612-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260930100031.7338-1-aethernet65535@gmail.com>
References: <20260930100031.7338-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

Just a reminder, I think you might have missed the question I asked.

On Wed, 30 Sep 2026 17:58:54 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Tue, 29 Sep 2026 00:43:00 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Hi Liew,
> > 
> > On Tue, 29 Sep 2026 03:13:06 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > Hi SJ and Community,
> > > 
> > > I've noticed that damo [1] doesn't seem to have a feature for saving
> > > DAMON SYSFS configuration.  I tried 'damo args damon', but it doesn't
> > > save the DAMOS schemes information.
> > 
> > If so, it is a bug.  Could you share more details including how the issue can
> > be reproduced?  Directly sending a PR should also be fine.
> 
> Yes, this can be reproduced easily.
> 
>     # make sure DAMON is started
>     $ sudo ./damo args damon > damo_args_damon.json
>     $ sudo ./damo report damon --json > damo_report_damon.json
> 
>     $ sudo ./damo stop
> 
>     $ sudo ./damo start --kdamonds damo_args_damon.json
>     $ sudo ./damo report damon --json > damo_report_damon_after.json
> 
>     $ diff damo_report_damon.json damo_report_damon_after.json
>     4c4
>     <         "pid": "4959",
>     ---
>     >         "pid": "5582",
>     16,17c16,17
>     <                                 "start": "4,294,967,296",
>     <                                 "end": "15,807,283,199"
>     ---
>     >                                 "start": "4,096",
>     >                                 "end": "15,807,283,200"
>     25c25
>     <                     "ops_update_us": "1 m",
>     ---
>     >                     "ops_update_us": "1 s",
>     46,159c46
>     <                 "schemes": [
>     <                     {
>     <                         "action": "pageout",
>     <                         "dests": [],
>     <                         "access_pattern": {
>     <                             "sz_bytes": {
>     <                                 "min": "4.000 KiB",
>     <                                 "max": "max"
>     <                             },
>     <                             "nr_accesses": {
>     <                                 "min": "0 samples",
>     <                                 "max": "0 samples"
>     <                             },
>     <                             "age": {
>     <                                 "min": "60,000 aggr_intervals",
>     <                                 "max": "18,446,744,073,709,551,615 aggr_intervals"
>     <                             }
>     <                         },
>     <                         "apply_interval_us": "0 ns",
>     <                         "quotas": {
>     <                             "time_ms": "0 ns",
>     <                             "sz_bytes": "16.000 MiB",
>     <                             "reset_interval_ms": "1 s",
>     <                             "fail_charge_num": "0",
>     <                             "fail_charge_denom": "0",
>     <                             "goals": [
>     <                                 {
>     <                                     "metric": "user_input",
>     <                                     "nid": "0",
>     <                                     "memcg_path": "",
>     <                                     "target_value": "3,000",
>     <                                     "current_value": "7,855"
>     <                                 }
>     <                             ],
>     <                             "goal_tuner": "temporal\n",
>     <                             "effective_sz_bytes": "0 B",
>     <                             "weights": {
>     <                                 "sz_permil": "0 %",
>     <                                 "nr_accesses_permil": "0 %",
>     <                                 "age_permil": "0 %"
>     <                             }
>     <                         },
>     <                         "watermarks": {
>     <                             "metric": "none",
>     <                             "interval_us": "0 ns",
>     <                             "high_permil": "0 %",
>     <                             "mid_permil": "0 %",
>     <                             "low_permil": "0 %"
>     <                         },
>     <                         "filters": [],
>     <                         "stats": {
>     <                             "nr_tried": "0",
>     <                             "sz_tried": "0 B",
>     <                             "nr_applied": "0",
>     <                             "sz_applied": "0 B",
>     <                             "sz_ops_filter_passed": "0 B",
>     <                             "qt_exceeds": "19",
>     <                             "nr_snapshots": "0",
>     <                             "max_nr_snapshots": "0"
>     <                         }
>     <                     },
>     <                     {
>     <                         "action": "stat",
>     <                         "dests": [],
>     <                         "access_pattern": {
>     <                             "sz_bytes": {
>     <                                 "min": "0 B",
>     <                                 "max": "max"
>     <                             },
>     <                             "nr_accesses": {
>     <                                 "min": "0 samples",
>     <                                 "max": "18,446,744,073,709,551,615 samples"
>     <                             },
>     <                             "age": {
>     <                                 "min": "0 aggr_intervals",
>     <                                 "max": "18,446,744,073,709,551,615 aggr_intervals"
>     <                             }
>     <                         },
>     <                         "apply_interval_us": "0 ns",
>     <                         "quotas": {
>     <                             "time_ms": "0 ns",
>     <                             "sz_bytes": "0 B",
>     <                             "reset_interval_ms": "0 ns",
>     <                             "fail_charge_num": "0",
>     <                             "fail_charge_denom": "0",
>     <                             "goals": [],
>     <                             "goal_tuner": "consist\n",
>     <                             "effective_sz_bytes": "0 B",
>     <                             "weights": {
>     <                                 "sz_permil": "0 %",
>     <                                 "nr_accesses_permil": "0 %",
>     <                                 "age_permil": "0 %"
>     <                             }
>     <                         },
>     <                         "watermarks": {
>     <                             "metric": "none",
>     <                             "interval_us": "0 ns",
>     <                             "high_permil": "0 %",
>     <                             "mid_permil": "0 %",
>     <                             "low_permil": "0 %"
>     <                         },
>     <                         "filters": [],
>     <                         "stats": {
>     <                             "nr_tried": "2,000",
>     <                             "sz_tried": "1.801 TiB",
>     <                             "nr_applied": "0",
>     <                             "sz_applied": "0 B",
>     <                             "sz_ops_filter_passed": "0 B",
>     <                             "qt_exceeds": "0",
>     <                             "nr_snapshots": "172",
>     <                             "max_nr_snapshots": "0"
>     <                         }
>     <                     }
>     <                 ]
>     ---
>     >                 "schemes": []
> 
> > 
> > > 'damo report damon --json' provides
> > > more detailed information, but its output cannot be read by 'damo start
> > > --kdamonds'.
> > 
> > Maybe this is also an issue that we could fix.
> 
> In my opinion, this is not an issue, since there's no documentation
> recommending we use the 'damo report damon --json' to generate
> configuration for 'damo start --kdamonds'.
> 
> > 
> > > 
> > > I'd like to know if there is currently any way in damo to save the DAMON
> > > SYSFS configuration that can be correctly read by 'damo start
> > > --kdamonds'.  If not, would it be worth adding one?
> > 
> > I believe it would be useful.  Please feel free to send a PR.
> > 
> > Nonetheless, we added the json/yaml kdamonds config support mainly because
> > there was no good way to flexibly configure kdamonds with the command line
> > interface.  Now it is much more improved [1].
> 
> Thank you for clarifying this!
> 
> > 
> > I'd recommend using the command line interface.  That is, you could copy your
> > command line setup in a bash script and modify/reuse it.
> > 
> > Is there a use case that it cannot work or suboptimum?
> 
> No, CLI (Command Line Interface) do very convenience.  I can write my
> configuration in CLI and it is very readable.  Thank you for letting me
> know this feature!
> 
>     #!/bin/bash
> 
>     # update-damon-config.sh
> 
>     ./damo args damon \
>     --kdamond --damon_ctx --ops paddr \
>         --monitoring_intervals 5000 100000 1000000 \
>         --damon_target --regions 4294967296-15807283199 \
>         --damos_scheme --damos_action pageout \
>             --damos_sz_region 4096 18446744073709551615 \
>             --damos_access_rate 0 0 \
>             --damos_age 600000000 18446744073709551615 \
>             --damos_quota_goal user_input 3000 10000 \
>             --damos_quota_goal_tuner temporal \
>             --damos_quota_interval 1000 \
>             --damos_quota_time 0 \
>             --damos_quota_space 16777216 \
>             --damos_quota_weights 0 0 0 \
>     > config.json
> 
> > 
> > [1] https://github.com/damonitor/damo/issues/3#issuecomment-5655965736
> 
> [...]
> 
> Best regards,
> Rui Yan
> 
