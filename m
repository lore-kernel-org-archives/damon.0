Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455369;
	b=JjxAid/jfvRjk0vGBMVsuOrkNIt3QpJXzhzjEdlfMNVkQDK/koV0tI1bbnqFvasEoGcH
	 ltPKkaQxf9rH+qzGleXABDPJQFyRKnOdCfGvpG5feEH+RmWMZ8+XNZxJblrEd1fFgW5ty
	 vtEEAlAZCHG6OoMfvoSNtsKV+n5d8WILO4VpzdkKxNC2QQNOC723i4Z02ozLbn4x9bGY3
	 p/YZ/n5kcqNMEvH24xYbMKv9fQEFnaSzZhwV2SjqRNx0Sqn72zTBMafUVTEE5EablNBWs
	 a2sAkqGfy8T+QP3F+8tDFCyu/THRXgtShuzc8WQck9X2gAPXcOJCI2ZGSX2ivFtIyvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=1YI2orZDPUDngnmyZYKSupAwoF5o8x/LtOe/S2TQEqQ=;
	b=bPEHG8jYaHERfYuT/Brxk+yE0tRVvKcYwA/I2uq4LIMLol3UatNrt5Hm1FWtA+OL3a78
	 Vbpd7ocEUKG5IN/qyyqPqBHIaRtI4Eq7yjxS8eyXl31Hh1WFDlNL4rtFvMfUo8M4ZnueB
	 zYzmUP02/OpvqWD5thx22DwCOBSlaApNp2B5N4TD8xdTHo25EcctvUIavovs/U6eq1loa
	 epVpoC3hpAv5/9BtTKOAMbkcpo+3pCHyECNL4YLyKEzVmDzSs5v86Hy5YH2R+fWPEbwvT
	 tz5lAaeuSBpv6ThPKSlxqSpnENh9bv2Cn0hCWJgxjAaIgtNrXPwRRqoW463wIUT72PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Gt+H/MOf";
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F53606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41F53606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gt+H/MOf
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36f936424f2so992912eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455368; x=1796060168; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1YI2orZDPUDngnmyZYKSupAwoF5o8x/LtOe/S2TQEqQ=;
        b=Gt+H/MOf9vzMi3Ybn0Tr5ey7O36g/CfDXGD++b62/+n0cy+oVt/EjIugCGjN9veOj/
         M2HKYa+RnIw97s79WDfrpn9lWRgacVTQhgGfheDoczVig6ybzE9J18iZjvDacXyXw+az
         uzwUX8PecJmWIpDe8LC0JBPt9+RwcAy+euuI02poHDxuvD2WRLLGmM+O4l8Y6i7cqIin
         MEGB6ywNvQh8KEKUgNYr2L/a/QyuzLWizU5CcVvq+dj14F3MozhdLHM60gciC/Tt9NK1
         8R7diUd3MEgFbwlqUBbZWXEnmLy1uC4FBM6JRLkTS2TBahH887FJSLp3wN0wPFHfB2q2
         pgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455368; x=1796060168;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1YI2orZDPUDngnmyZYKSupAwoF5o8x/LtOe/S2TQEqQ=;
        b=fXRDGHv4s8kvICeaZdN1g1pWkVjGQdp4QV63S0ptBZUWhsaxvZ92qzr1Z5H+v9A9vU
         sHwiiOivJ1JM75WDo7EbNsYFWsxFZotnttAQRuWC+TyRK4y+aHpn7AX5HBG5IDbmWEyl
         Rihb5qr5cNBWEAloiV5W1ZBaTOZh0Pq+x9M2qmvm5qtgXSJkas5lYV1dYuza/3GNo42e
         veGJOq1Re5RYMPbTD+k8AbiavuaqP2HcCopyaFUeDDjLKALhPl6iOqHAMQGGOEAPHysS
         dDHV2qWmcrJlTYrlvBiMQk9v0bqO1u3k7oxL4vH3/dhyA/p2g2mmQLIIDU7DW1POmd/V
         iNuQ==
X-Forwarded-Encrypted: i=1; AL+hErE6DSf6UFfC8igcnXnW7f3tCYXy+u4ngDxF5Vru8RXonpfB7c1ap2ezGJKya2zGx1aEmR90lg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/7wy0c9eKrIpm04N8Aj6wUaALFr4w/zXSrgktntNZGr1F1SEK6
	+6yO/G1FKpTCEfODm54FAX9i6AWClnlZ15eYtK8jPWXBOU7ZCbZUQ8+V
X-Gm-Gg: AZFdTZecRNiK1m77MFmLxyZnIdQ0oTlGGIE1nb6EGU7OsmSzRmLouPPQAt3z6fJTdqI
	34YVZ8XdRzLcwGQGYQphGtfwo28eApFHvUmT6x7JdYzlp4KS2A1sg0uKyLiSxF2OKkPUsfNYKFK
	28xzSukOcSedfiEDwUKVrO0agny252lZn6j0kJTM7F56mufxZryFMbeL7EKr1BH3TeGrZE8Wkiv
	4SL3Vmq0pCtpNvwyUdg5/seqOo6zP+U8c0QiZMDBPQF6aAsGVkKOK6PGkjZXmjG97KAdVoCmMv2
	7jbJArkeOmFSYRw7dMPRdh289KMMMbM0CSxssX1LbBvVnIhqKH146IWxgue/ub3TC3OsG/6RBGL
	heTasnYJW2j9AVZfo5q2sRmbIz2QT+FP3kLnwmwnyxUcNYtboyyzj9hqlqRDzwu4djW1JOa/SoR
	lZ9qifjbHOWuH6+WgFW1H3pOu7mr8+v4zCEK0CrYpI0CIV2H/iz1DvzSKG6YvcH17qTjYrld+G2
	pXXADcVcmwO1jMbjO9WDOoQfVvD8zJZYkbBPiE25yR3HhjKeagQW8MAEchzE79MdbL8stGp42eZ
	a7IZDHiB66Ir23gLf11faSYyHi28f75zPrXCyaq40+QonML14rHpqtISwg0y5SX3v/9kurTUj8r
	PM/GSgh8o1MItXhy1wF7jME5ayhuZaWP9Mvdr7QeMFvMN1MvT/6gYtwlVmRkdq2ANDXe3GI/ILU
	xHgmR0jUk=
X-Received: by 2002:a05:693c:6010:b0:385:849b:7899 with SMTP id 5a478bee46e88-385849b7adamr14110309eec.4.1795455368271;
        Mon, 23 Nov 2026 09:36:08 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:36:08 -0800 (PST)
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
Subject: Re: [PATCH 07/27] mm/damon/sysfs: implement report producer
 directory
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:24 +1100
Message-Id: <179545256498.4.5820255102137100111.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-8-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-8-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 12:59:51 -0800 SJ Park wrote:

> Implement a sysfs directory for each report producer.  Create and remove
> the directories for reports/producers/nr_producers file writes.  It is a
> placeholder for sysfs files that will be used for controlling each
> report producer.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
