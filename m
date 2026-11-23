Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455409;
	b=1j/F/1fxFDdiS89EIIfFpcD3WGSArw01um6D1ysOjQujE6xM76UaiJz9GwbF1T9s5Cd1
	 eCPojG/vHwUUJsiYv89wpyxMq0M3DJ9Q2vG7e25aWfkIufKG6lwxMTxbhtJK3voGurs64
	 NFM+uxcmvbqNhtXNCWsmo59wta+KpA4LnMYQipxwVp8j25KkXSty74GgW2eJfG+lIX0XX
	 Uza6/kdicDf7SocV+0lNVAGOLjtovSj3tlyLpkFiVzfApFi31ZNgnyfK0c0Bhjcqs4yWV
	 hwdk9BlNZBYew8JbTHIiH9yZ2V7wqX6ScfUeOHOuwYxXS/GEh/qhx1aTtsMWgZLFnmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=WY8mFIQo7NgVJ+1F6gP49ImSV6baaGjOTA3lfUYDY1k=;
	b=yogsc/CYrFOA6Guhp8D4RnyDjq+34MC9HI1WRrXGVdcLK043YBNlRvcAYsQ7moV+xcb+
	 7lXEvA5PRgQCyiaJEXuXUNbZOtyKezZsHOLBtwNF6HgVo/n/edC3Y1RRkWgMmbphhLNgA
	 t8dSyoK3cRLhmc0Jqj3bNEgXspKBkLcOkSibbDXAP4FQvP8kPt0bU7dfiVgyY+cOTmEO9
	 Rv4lOywQf+0lpL/U0JlpH5PqHRowrISTVV7j8bknC99n8WvxVv5fjH/pSVxdRvI17eUX4
	 o4yDolrsYuqeEUMmELS6IdJldIb68ZpLlhPC/WsEAktLophKyTZgUdju9eXwAPvS2lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQIQCyMb;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EEE606A335
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9EEE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQIQCyMb
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-382afece6d8so661079eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455408; x=1796060208; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WY8mFIQo7NgVJ+1F6gP49ImSV6baaGjOTA3lfUYDY1k=;
        b=zQIQCyMblgWWlKayKRTOyB5WQEk71JSLvxywCTkdXpNKNCa0KbUYykW8mjKyVflVUd
         vK4ver0m/3I/D7tK4KV+p8tClaP4h33gCWNaE8yosyMZD5QoJh4CrTxhmamFLDetiY4d
         ZwLnrpWWfk4YWgXxgX01RsSJRKLf0H+gP1u/nBRgfI4UUbIBNaY7347aff8T92XjraoZ
         V3foSWIHST30o8MEpKJ10o69GRV4Yg4d9MxB4SunZuvq3G5AkWN3cSvc4LJrI27xBuPU
         i+tKLC6H9ZPmSB/NeWoMUWh8moBCJaO+Fum48KxlH4bwvr5toe75yPIADnnuYXoCBlUa
         7Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455408; x=1796060208;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WY8mFIQo7NgVJ+1F6gP49ImSV6baaGjOTA3lfUYDY1k=;
        b=1+7gKE22fNpfLRgY/p1vvpOrrV/XczgWHQCFNznr+JSSk32To0cycZiwATzCTwcCwY
         CXquV4cpl7opKEwKuwqm8ur9pURFPaRdLVFtPhPyoFwjz6q+moFXfLSEUbkSizxJq+5I
         PICVy6c0v8xnNovnuXgUiXBw/Ql/zUKyGtYsKuYIFgiQOpwTiqvauyQp+Z9m3Tl17MJW
         0BfquEbJ97spsLIM3x2hZKifYImHdGmx32tuNAPbQxe5oAboo+82rcNOc6atDgygNh+d
         OdhJ8Ycg/ncQvxxPQEou262GkumUGQN+X7fmG8Q5fs6H/rqrq6IX/4fuio45Q3T8QSRM
         mzcg==
X-Forwarded-Encrypted: i=1; AL+hErG9q84PGEZG5pZ6bu332ikwmIFLjQ1RxiL4UF2X9T8eo8Kexph8HLpMl1XPT362nRDOsIrqJg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8JGON6UPrapZqLJ21ErON7gfq1zqMpjspVipSiQIKPNQdgmxie
	/HMLbMw6CdfxF4B/Pv3ic2a+jH3RN2bO2y67gLNrx5wbg/3BATkMMSkP
X-Gm-Gg: AZFdTZdg/ZEeonjVXuNzdI+4AfxLUbZqZwTKGO0zz1DRebak865HJNPc3ECjN77IYxb
	+p2w8DgzR4ZQVIw3N1fU8Fb1gq7/dpjhnTReiPhh0jkBo6wCFHEMm831EKP0MZZZVU4XjmVU4GI
	dzdzUCZFTa8P3zyGP6zAkuNskg/o4mW4D8OI6YEkzxpknE1PRtVJhRy0EEZxqj5yFSVx+TwkAuA
	AwByc/5jwe5ML7BkuKKbTcDNSiElgK/K1nKtL+Bh3n/6mw3VaEPqJMmV7luUrGVjkqrozPhFljW
	BbGtJa6vFJMKIf1JOOr11ELOezOPn/V91aZMuPuDMox3Jh2RFPybv5u5RglccgCW7UON4qqdALi
	73rVLqwPDVsuJjjKsYeMGDiB3YQfIdbxxrA6TwGDTogqF8xnfjm1ucqM3HDQHkWSwky5qR4hmTD
	5aPBljyI5V3g11SfPbTqifq/zIctiY0ZrmBXH0isPajnSX8pPoFpKwwS+G6GZQhbqJymua+xVxc
	lQlGX/3pqXx8Dlt0vjUypTbSPFtsDVs2n/27zgz65vGkoJIsL0Rml/u7SG6wB9GMNt6yZtsp5Nx
	GqNG+sBWVAeZ6BDevtuK/ofW8kcIjOKf+Eljy03UzXU0J2AD3yKPlUut8ZBQKnWpaukgqxkOoa+
	UIxdoVUMlYz5rdLLeJXt3UictzWziRsdAmQZ+lLnr/kbgXUiOJ8bIL7VyXcsPvw==
X-Received: by 2002:a05:693c:42cb:b0:386:b621:d8ec with SMTP id 5a478bee46e88-386b621dc16mr2377883eec.19.1795455407856;
        Mon, 23 Nov 2026 09:36:47 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:36:47 -0800 (PST)
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
Subject: Re: [PATCH 11/27] Docs/ABI/damon: update for report producer sysfs
 files
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:25 +1100
Message-Id: <179545256508.4.9352836018196513728.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-12-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-12-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 12:59:55 -0800 SJ Park wrote:

> Update DAMON ABI document for the newly added data attribute report
> producer control sysfs files.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
