Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434718;
	b=PYSnBv98GLiYjYso6UVC4tIKNnWhjCQfq4OhlsTbKMfWniyDvZZDtqLZBGHwfa+IayeZ
	 G4Wf5/hh3TWamjGs0noKyLscju6PIslN8jvzz8KJq/Z04xPe4bQXDSfqQjYlqRAz0YBSi
	 5UbnIDeBcs456+ND6o24hjfsaU560asb2Cdk3zVtDtlMFbTWJ874P+G4xRp94wN1WbJ7e
	 g5e1SpFnkLLUz0vLbM/B4qZwhwC7qypZJpUfleUPNYDqyRDnFKiqPMOLxuYCDnQYKsulM
	 dtWNFe64S0xeGPwL+G+meRFdRmsNwkduNUBhFeG7AkPvN4j1Mf5xyU5Uk1NpYDHlN7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BaXx6tWMUnSdOgVVvL4AQK9EM1ThSqCe7/d3jCCTlLo=;
	b=tOioUojZ8BvhxvzZVbuUczt9oydzGQBoh/YO1oOfrx8bUCu6FQ8wspoZKKi2THHb1rcT
	 b73dwRLY2B5a/t456yny1i1aXUjEjkRM6U49h8dw+NK3iM89DtbmDGYXwIBOLefkicuN3
	 +QN047zeaHmTSCTWZpq3aMCYgwZ32J3soGSTo+aCvF7CoiokO2SIcppJGSEOvf/F1DY01
	 Bma9NaCKTY2vdn8+36+TV+aDyWWdTuTO54fZ9QcOQBMs5jfyPaQzenPO7PyfikH8tIUve
	 NlAU4hPMsVa5BUCpskrevQMaDAQbu5+rrs1YmkvzjrBPlYLL2eDwWxnPWguhdAXkmPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N1nCADRs;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5336606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 11:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5336606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N1nCADRs
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-386b8f2f671so226647eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 03:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795434717; x=1796039517; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BaXx6tWMUnSdOgVVvL4AQK9EM1ThSqCe7/d3jCCTlLo=;
        b=N1nCADRsyiaRMWH0f3yi+DvG8X90hYzdA8rkubaS4l4x0O8lzOFqV62DLMqF6dFjKW
         TW0Dn3OEaa4Hasux1oGrmfvbop42GTv8aTDbHU19Ugq+WegbhlXQe68tchLYc2Zd/5gu
         WwfSTd6itFQ1IhUrrQiumbGSE5SFE9OrNMk1ZxHHW6gIzbi9ZcMxPMrfem2mZ/f+D5uL
         cHgIKexJwLFT8ifXehIztk3mU07iQ+34RZcaviTS2g3dWOa8cQfOWy5j+bcsdmN63kFC
         tcuCnDGufFtTXgqbvthoWQ3r1QNNaVfbTaqzV3i/6XiqKdYTcgpxYIV7eCVT/ocMy/Yz
         6j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434717; x=1796039517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BaXx6tWMUnSdOgVVvL4AQK9EM1ThSqCe7/d3jCCTlLo=;
        b=AuXlqjGfWoTe4pD1/fWMk90yQPxp/d0njZ08QPJ6UQFneiylPFNbB1ShVuJprMPd5/
         hGyuz1v/y0Fp/PLKI+Es2kDFst7706VOVpqTWPasUD18RQaMj3G1M4suRiQAQQHGd4sk
         81B3h9UpVY/p8mbgyBjVVdM9hgXEdlaUJ2tuW2URpHEOPGRCU3GCh72EhF9Yym8DEoan
         PF0c9FgO2bwpRVSkSvyB57lpb976XghROeOkQae8iBSMWxc/lag7MWvE9/RHSJEuUPKN
         9Xy6V4cJc0NMkKsAIlK7U7ByHt7ly/afe1ZNgdS0DLTtLWsQWH+a3ZNiav0KsLTSSx/q
         eMjQ==
X-Forwarded-Encrypted: i=1; AL+hErHd/jeE2J92pq9pmxsl+5B7+c5cT5i5LKyzq0jZ+6SXalHk2nO+iGK1zOxvidfktZaaLHHXxw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+w19iiN03EZ+YiRqJYHIgMSHKiuCTxJQjtBdNdncUCc7UYYm3Y
	KygyHaINp5VeTEKzIcDrEMnymvnqJoFVzfAOtTs5mwFbeavBUUSig2sGgC/A6G5v+58=
X-Gm-Gg: AZFdTZdgLmhPhRW87wo4K9v2ABySNeia7HftUEGDtj/GyYwBMehaKKIf62pOyG0npWf
	dL86ekerXaEyAbZqtP+lAq+7CACdCbe1FQTsh15fbxTPE7NksouQXEPKqYvHobKoJlY+fD0EO5C
	abDx2GwRwmU802X2UPHMz0/1SEFxJ3zOEUc8kLs+Bv02k0tuumWL+hYxI1Gq4VC+bAQYAVatoI9
	Of5SyHn8A96wnusHEnIGOTjjU1CLuKYraUnI1q+3PwGgVfGjoWT8T6ersfXmMgsuFC1C1YKHkr7
	njgbrDhCkdthKvZwrQ5srdsZbwbS7Dax3yqqKoNXzQZAJNRi+NiKhbn8Fzw8edIIE5Pw626XIV0
	K+Y0Sk+Dp1F9KPzyME6oAixcEmNsX3Ul5hdYvzqEjbhCWuxsoUY1w0hjvy+IZtu+tdk7Ut7xryG
	CJLPJJXrf8tIBz4z5Ebvy8eOwdee/wqUHQ9IGd7wjZxpdBQnUhNJbWJX/684Q9FTugbxC3bxvc7
	7JurYUW9WTvhzmQx1hDFBlpNmzwWX4qMhLJxLza/tIXZPkSTAgorUeZCwbAwTDGatfsWtPlr9Q3
	KEAe6bg40mHw9xW4UkmaoEN+2DnN2G4dGx6zIeWD0hh1T/e4Z8y9udyHx4oRfjVKJV7j
X-Received: by 2002:a05:693c:638d:20b0:375:c862:31c with SMTP id 5a478bee46e88-38571816d35mr11427131eec.40.1795434716798;
        Mon, 23 Nov 2026 03:51:56 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aa203267sm11941276eec.0.2026.11.23.03.51.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:51:56 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 07/27] mm/damon/sysfs: implement report producer directory
Date: Mon, 23 Nov 2026 19:51:40 +0800
Message-ID: <20261123115147.8221-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-8-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-8-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Nov 2026 12:59:51 -0800 SJ Park <sj@kernel.org> wrote:

> Implement a sysfs directory for each report producer.  Create and remove
> the directories for reports/producers/nr_producers file writes.  It is a
> placeholder for sysfs files that will be used for controlling each
> report producer.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
