Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706967;
	b=sOKf/uYH4uqIyHVRcUC5yYOZlo8ikBDaYE7mPpOvSD2UOf+a+gn6mluCCsQKZqxV4A6S
	 hZtfoU7A3Z66mq6RUA5NfkaXBkQ3TehjgvjF2UGl/gpoB1Iy5ltHYoFJiZku6ULnSV3cv
	 A1E6G/t4gpf9OigFncYaSKC1tG6BfaPxGCsCPeZO4iT1FweD5+UvEMSl0LLzRZapEdIPi
	 73+07azx6UwVYgDEDbQbcyeNytpVdWJbiMASbEEbMZt+QE+YUFAbWqs5/GmcKt/6f5Mu5
	 plmeOIUHxhTrzFiABvpK6miJ9bTP/Q2avROiMkRFQSmL3LkSHQMsC9A1obJuYJNpvoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=ONK88Mc3FVMhpnTXlcgn9JF9XGNsz0fFBW8JVFGM8tQ=;
	b=3sqe1yODXEdJ2Gom7hc8SUJDIzok3Con0BdapYNjajKjApVCWXIBQDlxofvEaBxATD/8
	 cXSGlyzzEf6RDS2bKU1S/Rhpkt5cp7dGy8QQFMDz4bJQbmmPfX22kS1Eedl0hVJgaSbbD
	 CCIt3c3SdAN1al0Yg2JHu/L9lbceOCIauyR0Ob4Vw7Z5YO2IXGsqdNQlYGn1DVuBHsTqv
	 Giq/ruFOwPy2+jYQjppLn5iLICzNtmrHWbWJaQxwkICwAHEZUWQ74lPZFrqdtQU/KVqfr
	 7O1rONuiFvYKevhD4+g/xdsHFdBx+0ApivvXNsIUa6v9a9R0YutSey+WJtpxzylIcKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N9+DQjlF;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900C3606A327
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 11:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 900C3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N9+DQjlF
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e613f813b0so13836425ad.1
        for <damon@lists.linux.dev>; Tue, 03 Nov 2026 03:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793706967; x=1794311767; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ONK88Mc3FVMhpnTXlcgn9JF9XGNsz0fFBW8JVFGM8tQ=;
        b=N9+DQjlFmrR8YS1a3OGvF8SCJgu/Vhf6AX1q1o0YSm22Ag6Sph6VBfXz+Iz6iw2r/z
         GH91vXGiRDrDgc/xCroivX/Mwtao2ev0RkMlz+fBkRQ5VPdUeSCycffs2VA0cPUm3lzS
         pI/ZkDuJNOzrLWkI12XeN+H3XxfZBNu5J6NkcozOLiU0Ift/8IAYcjTrdjNVFHTL6A9/
         6SCwKWw1lil70IuJ31RuErUlRsiOwv1X1rrxmLg5lcwo6EaEQQLVbD275zCuw9exXNKX
         zqwZJ3lmyzoMGbgDH+w3W3oMMvOYpFmx9FuC7EVZyfYkwSwvApdM3z9gDoVekHShMkuC
         91uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706967; x=1794311767;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ONK88Mc3FVMhpnTXlcgn9JF9XGNsz0fFBW8JVFGM8tQ=;
        b=U+Xt1euRf/M3c/JF/Mffpzq1rNKtCuKC9sLEAiQx+Kl7fA4HjeGJ651pZhpjGWys8e
         KXNbbZWxOlRsGzkuiNCOekPVHdwomBU8xWkXHXAvsojg8wQfkBvrL2Yn/LMI3y9EIvep
         E7OLE9FbwL9HIdo5Lqrn0dsYLRdrGKxTcZNPTxbpA/WjNlVuFOVKy6IKCqex2oHpYGbA
         QVkalhJbgKpDfIgRXyhT8Y5CpgkA8IJQrNyfMdR4Dd9E/6FLStJ8oXeTMI3Tl/BL3faM
         j0q1nKYMtgynQGI3TEUcsDzE5CUQd1ivAMPwUuuPPPg53SGh/27E32lamNO+HbYqUoLA
         eeuA==
X-Forwarded-Encrypted: i=1; AKwUvByRd7E96/WG6QDtwCqt4H0zfvnTSFheqhUTqsSvg8c0J5JKeWSRjKZU/13jyNsfMsYR+iip/w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Nh1fv5XPvdRZJLxnPXbyfh2X20Sr9QMvH753pNNVTRN6tC4aT
	L4TMy5zeyG3P8vnlDK6sbTyITsHpWoWSR1oVTRMoYVG1wDXF5V6uxbDQ
X-Gm-Gg: AYBFou0HHf20btJmKgjruvXqekEDEd55Wu+WdQYO3aPUk87Ju5wCFiT8xO9VSnqfx/j
	vIivQo290ujrib5zw8glBcgbJ29Vq1hDiG/MZVYcLSiiu6tlCbNiz4HDQezotb/AmL3ksqhxGL7
	FTAtoKLCSbxReTsKf0hAJ36bpfPROM7KNGdUq7WoXflqJ+QHM3BkoGNpYhmXsSbQMFskB4IZkTC
	QF0yrHchhB3sHxNNhtYtwkoaPR6voASfgM4SgOTQEww/DGLh20u8wSn3Yk2Xn3ls2ykmzDAmGqO
	nly6vh4uSpqujK1B955hqV7mQv6zQmXijX7H9nylhWiQN8JH1oUbvEqItp2jyGkftNeh8N9Kz+R
	3yCdI08MTtOz6K10xI0YCtxjUir9haSBvuhSq2A/QU9oSs3EdBw4RuQX7CaUaWGI2nLDYfDS/wG
	YEQdHqQCZz5rdpVOzvsoeR1gs7L/AMQCqMlzrCwaltiq1IAwmQK4d7Oo1gd1ZqryowCsxFbuA/W
	JCbOMxRmHqUmqo6OtfVUYWUvo2cAzRfecGwoKuz4TWOzx0hGII1/2EhlLBthmTCQs6UmlWtBjCy
	bUawzkv9nPArlJWReYP3Sby5sIVKFOMhWyFBDZqz6b4riNRTpIUgvFtmsixmTa00P/cDUXF4HvC
	bKicJ+eoExBAY8EobsV4pWVgsnz4=
X-Received: by 2002:a17:90b:1b0d:b0:3ac:36c7:c144 with SMTP id 98e67ed59e1d1-3ae89776936mr6987759a91.28.1793706966861;
        Tue, 03 Nov 2026 03:56:06 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aebc89475asm5134252a91.0.2026.11.03.03.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:56:06 -0800 (PST)
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
Subject: Re: [PATCH] mm/damon/core: reject empty access pattern intervals
 on scheme commit
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 03 Nov 2026 22:44:03 +1100
Message-Id: <179370624368.195197.14262032219867976650.b4-reply@b4>
To: "Xiaolei Wang (Kaihong)" <xiaoleiwangxiaolei@gmail.com>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, david@kernel.org, 
 error27@gmail.com, "Liam R. Howlett" <liam@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
 sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, sj@kernel.org, 
 stable@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>
In-Reply-To: <20261103105418.362459-1-xiaoleiwangxiaolei@gmail.com>
References: <20261103105418.362459-1-xiaoleiwangxiaolei@gmail.com>
X-Mailer: b4 0.16.0

Hi Xiaolei,

On Tue, 03 Nov 2026 18:54:18 +0800 Xiaolei Wang (Kaihong) wrote:

> At runtime __damos_valid_target() evaluates "min <= x <= max" for each
> of the three pattern dimensions.  A reversed interval is an empty set,
> so every region fails the check and the scheme silently never matches
> anything: nr_tried stays zero forever while the kdamond keeps running
> normally.

My understanding is that DAMON just does what the user asked for here,
so this looks more like an input validation improvement than a bug fix.
Since previously accepted input would now fail with -EINVAL, maybe drop
the Fixes: and Cc: stable tags, and mention the behavior change in the
changelog?

> The same holds for the watermarks thresholds, which must be monotonic
> (low <= mid <= high).

Not for all cases, I think.  With mid > high (and low <= high), the
scheme still works; mid just has no effect.  The subject would also
need to mention watermarks.

> +	if (p->min_sz_region > p->max_sz_region ||
> +	    p->min_nr_accesses > p->max_nr_accesses ||
> +	    p->min_age_region > p->max_age_region)
> +		return -EINVAL;

As Sashiko pointed out, this would break the DAMON sysfs.py selftest,
which uses size=[4096, 2**10].  Maybe update it together, and also add
a kunit case and a note in the DAMON usage document?

Thanks,
Aveline Noir
