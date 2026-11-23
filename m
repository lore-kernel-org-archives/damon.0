Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455443;
	b=YcxM6m3PY3CfC8C3HdUgiH0EQn/vSm1qg+PAxhJjxXi3PwmOBZi3rEoQNRFWUvjCLGGb
	 TxPNuSp+K+RG7xlLo+Wd+rjVMF70Cd4Oy+zDy2e++V5m5CRN4LVWLV7DQV22Y15kTltm+
	 P3Uv/amTSabL2qj1nFgtZgDsFasS5b9s5C5L5b//2iRVxiuuKVuxWMj/OKEc1mgyMtULy
	 lN/dHRFWh86o9ZrJFF/ZJSoXPCE93zoIv+izvJ77O4hQVRc9ZqShJ5cozhicjcx9cOZN2
	 JeL1nMahIYB9l1hk8T1pIFY0f9X8gyInK39oMQEnTBlGTolKVJYeraT1WX6Qn+RPlPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=K9/G9Kxx1sGa+ECLvFARdPS+xdwTBfsM5TBrwJfCIRE=;
	b=KjjxhZ4kDXfi+pCkJ0+ZUHeC4mzTSWkZuwH8A0a2zfUCYSeVD2bNXi6ZVwqp6EAbC5BI
	 YBKUtjuEK7aJtr/YsGnw3nelf6w4bSQFqQG9T13QlKKj7+Cx4SINUTvnhUKOR/1UUyBF5
	 CK6PC9l28cCtWe4oKRV1spLk3tziaui5luO8k1Cc+RRLT4MUM5eXYhmrGH7O+xkSPlN20
	 lRq3EO4hpZ0d2LnT4IH04AUBsRMn+OhAbfgHTyRb4zTWni7nxdvHCbLIeMbcfwXpeig49
	 EZw/iU7ZYK/l3UoPwHImn4Xp4X74pvXCX/uDZoKUMMS1gRuWlWyuhyJmeyl0hjJQuIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vWFbyDsn;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354FE606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 354FE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vWFbyDsn
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-3869c1f4d19so839737eec.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455442; x=1796060242; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K9/G9Kxx1sGa+ECLvFARdPS+xdwTBfsM5TBrwJfCIRE=;
        b=vWFbyDsnizeFE6Eq8YsDNhQ0FDzM99zBD/GWvw0qtIzHcV4+LDoUKA/cexNNtIGgxS
         jV7cYS3Q18sYPZG9H+FR+X8QINpSOPpcSdGm3XmG2LXw87e2osw5+V23e/pWndkpdkeO
         uGuOQoKGyuaUP0cicQEOHBq013t1qwtn9SVVIlhc/Odss5KH/rdvw9GMQOfY0uGLZ/Lv
         fdv2pgJbk9uJqn93qYcmqa4uPbu63KaZg9GVV3M/JbVTyGq+yqTC89WiiOlDv/N1Kvxl
         m93eWVZwXbR2gwuGzfUmrsc2deOS+47tUdZEjOf9Umswt0M7ApBdrJV1gk9F04LZrLfH
         XIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455442; x=1796060242;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9/G9Kxx1sGa+ECLvFARdPS+xdwTBfsM5TBrwJfCIRE=;
        b=11+Eu75KRGK5H3JDzSPTKjz8QIvqMwRM5QLSF0pnvCLPLbX+GDd8045Y1MHN3y7/jg
         3zDQ15nAQCX/3nKOIMbK9hcPYeo3DxBd4fqFCWCv1eK7/8Z0wsazPtA5pCB8rEaxJg36
         J2fQO0dPAAe9ssa/Mmp5tAdaeRiRARTefSPADzinfFJXo7SfymFUIdbaKYOG/klV9TKX
         JlsFI2+ytrrgEsDqn6knbLKB49eK83NOXdwiJFQFX883Pv398FO0oZAeXCyMJelBfjdo
         tHDVPtNpvdUtSRYyYlpeyfXqh1cqyXOoj+XtjMO5+cEe2IGLMDvnVLQBOFldq/71exS3
         qC/A==
X-Forwarded-Encrypted: i=1; AL+hErFD9UPIjPO47TKXIFMZTdKoZrTH8tbYBTfigBAnvY7PEXUmdeR3eLdJzB5EkRY+3+4SWos5IA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+MxAmKSBFfYDX+R6xiTmsJuzd3MczNj3MO9CFIqnim2jmTMVv4
	QpUJMdEjjDi64ExyNoxOd+B3WRecoq9UCPoCM2j+4GjU/3SlTsyyOJjw1u788MXi1FyMDA==
X-Gm-Gg: AZFdTZeMGo9cUz2rJJcmFG1MEr5q6Ua6mtupxjhjxAuKoO4aqN6dynpFmqCn5Sen7KK
	UYfJsz4OAwiwcp4xUM/wVZo8TWJYfYYkQbJHTzRf5sDAN0/uojUZF4OeJJj20T/PBUO9HbsM5J+
	7InhytHYDL3JrLukUtT59JoYc06aMDWaZFxw0MLGJFhMZnZLRTA8cebaHuWDy6mc4QOHa5zTGfn
	zMsHn97tjltqGPurDxNi+tXKaQZmwB5xOptjjRPHSXztQqfIu1VjzyLklYkKYRGZX+ZQiWgL6yf
	7su9TCS0vmNXDwecIYRoxNKeI5wIg3ETEwsPMVVjQpfpFE30k9/Ok04ksWZd2CJOg0cxl5pTtIo
	TaUsZT+P8YuYzrc/GlxSERzaG0mddWiVdIWcEkfuPH0rQjcm7KfkvvbbGiwkIJlAdFWkWmvzVPJ
	77IU90REVeqpw4mXTugS+CInh85wg9e4XK0oNcTpcxmXRekn4OpQXzfIXwhT8ACrXjmUPPC+xyf
	SR5WjBRSLkJZGP4g2io+BXCw8tbSNEkyWtTZL3LEoEsr11H74y7tYqrRL35RoDpH7n6Vwox10pk
	B9NFHmoT2VlP6gE+NguMy1PgUhVTeDPEJofpt6SgrfxGGRqdcn6KjTyEqUrH8Aq3KtiklXdfiLp
	o6zOHnQug+uvy8f238sf8NPoi2Z2g6SGbNoSkTJJMLppu/6US0lSULalZjnDELQ==
X-Received: by 2002:a05:693c:60cd:b0:386:98d9:d5cd with SMTP id 5a478bee46e88-38698d9d928mr10456445eec.39.1795455442078;
        Mon, 23 Nov 2026 09:37:22 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:37:21 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 15/27] mm/damon/sysfs: add filter_report_type file
 under probe filter directory
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:25 +1100
Message-Id: <179545256500.4.8792375728766851430.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-16-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-16-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 12:59:59 -0800 SJ Park wrote:

> Add a sysfs file, filter_report_type, under probe filter directory.  It
> receives damon_report_type from the user.  Reuse
> damon_sysfs_report_type_name struct for user keyword matching.  Move the
> definition instead of forward declaration, as the code change is small
> enough at this stage.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
