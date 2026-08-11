Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4B3455165
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467769; cv=none; b=E2pWXHFtfE042o0XroOruI47gFtkShPbVgtgYlaYXz9RBIdkSpvIHlpFSD065q1AThamuDVF+TYWGMfIKVKn7/J6yOJT+CKMoCRWZE9M4L2Ua+T/G2VrPSWNHrwO0heh4DHN1HUl84RpB+ebEpvpSdssU0JviXE33uHK/kQ6ndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467769; c=relaxed/simple;
	bh=rp1SVqNd1lWzghKHZWBSLaNSQ75mopP8yp8n71kKysM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miqRo73HeX5z93P2FIl5ez7BK9KolaA0N9rDasg2CulFO5WzhShcaAgvVGHn+iXfk/sWILTQa+seebGTfCzYnVtt1d3gD37rsth/Yc+m+6xLw0UgdpB6fHKrLCGXW0ZhUSXDDwzREJHBAnrYFMqSdXFSa5PcepfbN2vWdKarrzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5K5xfcW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5K5xfcW"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84830c774a0so131739b3a.1
        for <damon@lists.linux.dev>; Tue, 11 Aug 2026 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786467767; x=1787072567; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NkZaIE/vnqQhC836hZPxdvhdVxGgfRhensvVVjTTADc=;
        b=R5K5xfcW1PBCmB8wJOvwUkpxcaSYfMF72yBhfMTtftydHY0/opMGUR25rkzTgGXsN7
         sX8T8vOWWuOp2caP//q97AiXwV2ifseTfFhZtBHqHS1txi35pH2z99MKpPSU9Vcxb5jW
         vjhBtOHHXTgisBT6HwtqMJryghyKVYqMYlJG4FnIov9KoEr9mYY30IsDmZ/y1zGMZv1G
         9tXWweEzHExS5YJzHuFtdxjJo6F3Q7nvNoDw3WWVmXTamtm6FS22DMWrGLofMNMMpuNj
         d1UzI8pNQONuBUvwTbihq9o/8g032hFDPU4jUvmnqXTIibJCVL6J+ntCVyW3ucQhUqOG
         meAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786467767; x=1787072567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NkZaIE/vnqQhC836hZPxdvhdVxGgfRhensvVVjTTADc=;
        b=JhA8As1n4JRwnBldqJZ/KvYz+5N82FZURA62PgPQYU5Gx/TcYqMipSLHU2VAYsMJVM
         jWMpJpSW6ZPow7RLq4DlVvWqOJS73nWUhNnbPP+iDknq111+C37qi5WRTbNUNvFT+Ycd
         kC6iewmP03coBzFyHa5LGQImBc9Mh5tBeqelN7dK4eVk2DAt5oHyhTJf49l84N1d6CJt
         d5dob3GnRIbozL30xkAyZLX0I7HHhlKtIpCvKdU1Yt4GA70FA313NUa5NBzaW2m+eku/
         34SJHb282rpD6yAW4bQl6yBWFME0HVS7zFEbjgsxNyQcXAxqD6da+E2cSHtGImL1ezf1
         wYJg==
X-Forwarded-Encrypted: i=1; AHgh+RqBEX+rqvh4ajZMfnLeCeOTCFVm+HtlHtCl/S8Ks/yP4vJ9dXm3vWGAvymceOUSqs6vLMq/Bg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHn1bovBXbhFlN/Cu9VSO0Jsz1oT0evmNZvgO5oxfOoGqnivgB
	Xc+MuRdMQjCwCT6uPPfb09kbS5AGs6/KWLpUTO/6ft+LiuXzcrr9u8I0Pq/OJQ==
X-Gm-Gg: AR+sD13r26QqataCr3OqoY4ojFWd8oJXWhxF9V3io8bIwLsySQMUNMQQei/OWUXa8dZ
	Eic39r0WcqxAhJ8AqCb60cGTD7nstl8Vul0a+OSuDQlCdZvEh74qtxV7Br7PZHsBZgKgGhPcFNB
	vX493y4vhlrs48q51l5lgdGd897DJXGRZeuOLt2SueZYr+6to5T2zoW43tXw4QNRKaVNroDSXEh
	sS80/+Il66yH04P9dFWsiAsyoSduDHkvGIMoYAq+DHK9YLFl3UebpHqUofuUSfGULQ0EvUTj3Kl
	jsLfG4ssx5N2fuvw7ObjCvX7mE94vzG/JkoSdQ8ojv0KUeDMqfATOE9/E7YCvD89E9436uzeOdR
	1s0dkS0Lu2L+x7imJ1O2V83KcjR5rhtxvf20IiA/Nxzy1744c2SMLtKQxj76sxSoJPS0kHK5ceh
	M8VPbmWHtgLPs/Gj9LfvH43eb+n0H2NMYJvrst37J9Mi8sOFrU66DH6jc1Aev6Qdc=
X-Received: by 2002:a05:6a21:6014:b0:3c3:8d4c:6679 with SMTP id adf61e73a8af0-3cc2baf91c1mr7030040637.20.1786467767243;
        Tue, 11 Aug 2026 10:02:47 -0700 (PDT)
Received: from celestia ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14124451180sm1073882c88.1.2026.08.11.10.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:02:46 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	damon@lists.linux.dev,
	david@kernel.org,
	liam@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@kernel.org
Subject: Re: [PATCH 0/3] docs/mm/damon/design: add explanation of nr_snapshots
Date: Wed, 12 Aug 2026 01:02:52 +0800
Message-ID: <20260811170252.32705-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811135654.4901-1-sj@kernel.org>
References: <20260811135654.4901-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,


On Tue, 11 Aug 2026 06:56:53 -0700 SJ Park <sj@kernel.org> wrote:

> Hi Liew,
> 
> 
> 'hkml patch check' [1] says you forgot Cc-ing below people who are recommended
> by get_maintainer.pl.  Please Cc all recipients who
> get_maitnainer.pl is recommending, from the next time.  'hkml patch format' [2]
> could also help you doing so.
> 

Thank you for reminding me! I will CC all email addresses output by
get_maitnainer.pl from the next time.

> [...]
>
> On Tue, 11 Aug 2026 18:18:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Add an explanation of nr_snapshots to avoid misunderstandings.
> 
> Thank you for this patch series, Liew.
> 
> > 
> > Liew Rui Yan (3):
> >   docs/mm/damon/design: accurate semantics of nr_snapshots
> >   docs/mm/damon/design: difference between watermarks and nr_snapshots
> >   docs/mm/damon/design: fix typo of max_nr_snapshots
> 
> I requested changes to patches 1 and 2 via replies.

I will make changes in the next revision:

patch-1: "tried to be __completely applied__" -> "__completely tried__
to be applied".

patch-2: use two spaces between sentences.

> 
> [1] https://github.com/sjp38/hackermail/blob/master/USAGE.md#checking-patches
> [2] https://github.com/sjp38/hackermail/blob/master/USAGE.md#formatting-patches


Best regards,
Rui Yan
