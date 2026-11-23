Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455524;
	b=xIO0yOHpGZ0KI3iGe0kcXfpc8MXHdDfvXTjeDNB4uf5dhQoxPMsih+7oT0SCDJzvkVm/
	 XvRBtFb1oxfaXhfvkY5SBttaXl/V86l3psgWT9VS0QGt2TH9HDvW/2t9vTbu3xvzHCZYT
	 BJLzrGCm3Y7dUYEn+Ql52xly8sZ57mVyJLWARCz9Wx08MyO1A+gGqqzqEmORukzmGNP1n
	 FU1cOM4PT3rIWfO0c/akuqRTzB/hdXqAL4Go8XU8j9QGncuR8w8O0AJEi0Qes7fgUVKBF
	 XyWNOgQZg2fi54fUlK3ueRTh60BZA6aQgYANxNiOsbY4hmeTzxLDJG37r7XgO3SNnVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=ON4hm5xX/TESJ2KwEmSXnqTeTKDgHlHTMudm7RJl7Pg=;
	b=Gsuu7dDmMY3pPSX/aFK3nelrn7DlFZpBRONxnxOKc2GzfJp13RyP5k0zCjvo1ObtW+DQ
	 njfgbJpkHnNhNzzePOptVQ8Z/QLL/RU+e8HsDLqJK3Gdx+VfK4WEENnB58FZRpaksK+ve
	 aA/J0j3NbyzQ87Co0NYQrvh9L+Qb3Stz7rdviirMC6ArCmFjehmM5MfjNfbZq6+QQYL0m
	 DghcxY3A/arqUvkujB7QibkJUcX69EPmnl2doaF/krRBpS6YnjSg2LIgG1/0/7m1ZDMRn
	 XcQmlBHj07KmAWtCeqS3N0BiSLKbLydL/yWl6rAlCDzdo7tVdghq9FX8M/9yjHo8+mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y6XH9yq+;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EFB606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5EFB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y6XH9yq+
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so1376523eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455523; x=1796060323; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ON4hm5xX/TESJ2KwEmSXnqTeTKDgHlHTMudm7RJl7Pg=;
        b=y6XH9yq++TfVwZEDrJ9bxIZlWPkv3SYw/Q0Z3lgheJcJocCnCADNnDluqrUqx6ZzFm
         OwivyFt76rNdNtimYl+gCjDROHnjxy0Y4ewQX/fJYhJqhwRpz7shXC1Fv3dWX3HCdbVn
         3MQCiwNcLAgm4ZOvhtKnkmbI2LKxDIl6hpYV198GRALtLJvxb4lx+XiFXAynoTIUiPtV
         vxta1o7QVklXBHdWTFhJcJol8hQZqFncv79+Ic646BcTc0ZxHXHt8qDgnye/OUCjqZDt
         t2tWTrYM6Ns3Vl6WaulNC/BF/NKp04y1uxBHXZxR+BEaG29a5UhEVq5KtULRdPiJGISC
         e3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455523; x=1796060323;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ON4hm5xX/TESJ2KwEmSXnqTeTKDgHlHTMudm7RJl7Pg=;
        b=J8Kmbw8dSgTR3om5xOsRGojUZTQtgyQYeAOwYCd65R6IoQ6BRYbuX/gZYWsFS5LVUR
         Vh08U7pofhNKelOltsAVH3FNnSQy7h4/0fSf3QhPP+UiDIbqLwtM8zJ93pUIs+svVptq
         Xz+iaxMEVX+KflAfXKqPZXgekuh26agf3w0k61FVquzqAilqSB1nukMhCxF338KQvxWE
         Jkue6RtihnuB8jJoWMljDRvo2Dk7ccrWycR4Q0NpRw6+WLuEonoapciiDA1h8n3u4y+Y
         BWIpIQUx39pXBMLZm5dCeKVOWz26zTL0VYKVsyIHdL7yt1bhspIVSJ/anzaH79v4L/Bb
         41Yg==
X-Forwarded-Encrypted: i=1; AL+hErEvyiB7Q+ShZ3Kv5Sr4RziyCqeNS8FAEl2M5ujadWAOGS+c04Ds68b0E6Y4wokaeb2YaNJlpg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/yRR96f5JmeQJwtmWeeaYSW7tFJxUjAi/+GTv8voocmvLYbXe/
	VDrQk/r2F9nG3m076XlzxAsAGrMoZLbmy5DF1hBakdO7T8STDJSI30a0
X-Gm-Gg: AZFdTZc5FHMySg96cmiKP7qrma/CfhhE5nLoINtXlrxr99TV9nMVl2HcE351MReSv76
	GfYYi2+kWaHdr7eAgfActjFKEVlWilPtIQG4amlwVzhIaoqL4DpcOR8ouNWl66IKQcf6O2k0lcC
	1IFXDSY3rY8ePfeeQTuyAuqkqrpDNQQGEinKorFrkAJ0/AjmqblKq1me1DmrBsFI373gwxwFsfG
	pvPrb9VVNpJsg1u97OFclRKExeQhHPiWMY5swNZyzhctuSz2RppxoXpS8cxGejc1EYJ6RzDUEXa
	k/qKuCQ60tBBtpBB37v5r45SbHCeLbMnriOc51elD3oMdSJX2n42l39JEh7aIa4dO2fWVtHQDIe
	yUfCFh7Y03ZhJMHWJyrtu1HvlFkfBNMRXuoerRMeJhf65ZDm6kUY89WcgYaTFiMFQ+/Egqgh0nO
	9hWDH82oI6K4pSnjbLLTaPLQQGhCXPtecvXLtWnQG/dFdeGOdGSMcVhPpYTHWut6yX1+ipMB3Mm
	s/ZgP2JU/SHez8NFFnhKGofCdk4jW8nEkiWc7x2b1D+tTDK8QQdfT7l5XDPIJeK8W7tha9/FDT1
	e6y8t+TplaSsatWg1YEnMN8l4eKpHeil1wFlbHjfd73mScXr9kdxRS1Mxs1g/9o6WFhfTNWp73F
	opEqJXiVPu9AF3lUlR/CUlO6twIivy7ekzJew/RLXVlxhn4Ndv8+bJzJ8kSx9TQ==
X-Received: by 2002:a05:7301:6408:b0:36a:270:ce76 with SMTP id 5a478bee46e88-38570f2b27dmr13093027eec.33.1795455522859;
        Mon, 23 Nov 2026 09:38:42 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:38:42 -0800 (PST)
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
Subject: Re: [PATCH 24/27] selftests/damon/sysfs.sh: add basic tests for
 admin/reports/
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:25 +1100
Message-Id: <179545256510.4.17741169185712698444.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-kselftest@vger.kernel.org, 
 linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>
In-Reply-To: <20261121210013.130397-25-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-25-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 13:00:08 -0800 SJ Park wrote:

> Update sysfs.sh DAMON selftest to cover basic file operations for the
> sysfs files under the admin/reports/ directory.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
