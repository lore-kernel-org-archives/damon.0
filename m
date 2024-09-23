Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922110E9
	for <damon@lists.linux.dev>; Mon, 23 Sep 2024 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727058322; cv=none; b=EYvXD0VmD1j/ZnaNeoaeSFxKfFweUe8OKBGiSqFUo3aufD0bwmL1HkQwQqHrSJHzkiVbpYTwweofIU5ImT1v80QH+IuDRqZKVYj6VSOh4qRdtYOTHNcr4DSV6DpVbuCeYIP+0PouJ0FXh3+XFj3OXa/dlLvI1RYVtHPV70PYSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727058322; c=relaxed/simple;
	bh=xhXbNvM++7qKbgPSVqhFDU2ZhXaHlORv7ZNSLZePNZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arNzPGOTwgEwEUHpS2lMuuMuD/Ds14eVphTZ9N53YT9liFuQg50CkpVlyfdr+az8UoE1w6HBBVrTliJeuHCRCzfNbb2jnUZkm5q8SB9yyt7ma68pFykrqWG2t6qQgKWKAWdKgNESFWJxFvq0KPWvN0KQA/dE68howTOeFq4yXdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCtJuTlW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCtJuTlW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20551eeba95so32644805ad.2
        for <damon@lists.linux.dev>; Sun, 22 Sep 2024 19:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727058321; x=1727663121; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7aLKOb5llbH39oSD2wqFg2ImH5K/xs1d/3DhTSvBAM=;
        b=QCtJuTlWMNOcld6Dm0LDeuDL/wrmHD34XbWv4HzU3MWnjynsDaUcNgDbkCoXnJEQlC
         1Igqe9H0+q7siDBaNxWUKggQDZ0XqUXuVMeBwItf5K7Q2AjmrI7dcaUoDZz5j8uxrDBP
         /xmz7Amp9rJ2wsJZLBP+r08PHjCxk3umYUSiio2ndloO8TtJvg+Jk0lPsDaG5UI2v56+
         DKUX0si0Y5QjfsVChELDr3KizbdnsBbr9Yrf5GiKDWP+/K4wl92nnE+Vlos/Zb1Gegwq
         tc04spscGgx3EHllMtc3UsTByQSqmppfOXedwOtMkKBRoZFCdrJzBlDgb9oK8GHcA4Mo
         VoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727058321; x=1727663121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7aLKOb5llbH39oSD2wqFg2ImH5K/xs1d/3DhTSvBAM=;
        b=c3PfwFDQDnrW0dd+LnXbpJlhj7/SYhudeUFFUjtb6lSgPxRLac9gvd2UinOUtyVcXl
         oeDhOYk88SE01GoSnwEfe5JwS+fx24RopV9C/X2uiJ49hO2U4HYOoR1kklfGKryqG7s8
         NoYkoCWpVd2i91S5/YqWGM24codpCVthvOWbTlsB9OXVk7DhpTSk2Ki4PuQSRrk20say
         PY5lEiXEzSCDV3oaA+cfWt7kOIji8BVjxpUQj8bIfZpsKT7EilojkgxPQKFl6HQpQpN6
         m6CstcbiA+LG1T2d4b5MlaZHFqsuJ/TOJsMKqR3riXuJaWQBglKB3U+4m0o5+O7kFImN
         936w==
X-Forwarded-Encrypted: i=1; AJvYcCXEV6YZX72ClaEwDW56m6WB23gprpbZnUP//rmvPXuZhkeT0tcSqUBLTdwl0pWajw+MmvPqVA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywy2CxF7atu7DOHVqs/Bg+tbn/mr15uyMHzzjaIkWDYIoLUypWw
	C+ayxFgkEGysKsSS9FcCjCkIeep7+dHBXX2zECXTqYgV+53pac5x
X-Google-Smtp-Source: AGHT+IHMe8B9R9yeowkpYMpdwCkp3LhabZm8IJy9oinfaIcj2oqUQXGLPn9cSkJoTdRgN+hp5ZNI4g==
X-Received: by 2002:a17:902:d503:b0:202:3324:68bd with SMTP id d9443c01a7336-208d84421afmr140151485ad.43.1727058320760;
        Sun, 22 Sep 2024 19:25:20 -0700 (PDT)
Received: from tc (c-67-171-216-181.hsd1.or.comcast.net. [67.171.216.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079473e8a2sm124613895ad.251.2024.09.22.19.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 19:25:20 -0700 (PDT)
Date: Sun, 22 Sep 2024 19:25:18 -0700
From: Leo Stone <leocstone@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Leo Stone <leocstone@gmail.com>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, akpm@linux-foundation.org, 
	ruanjinjie@huawei.com
Subject: [PATCH v2] mm/damon: fix sparse warning for zero initializer
Message-ID: <xriwklcwjpwcz7eiavo6f7envdar4jychhsk6sfkj5klaznb6b@j6vrvr2sxjht>
References: <20240921195511.364023-1-leocstone@gmail.com>
 <20240922151121.469051-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922151121.469051-1-sj@kernel.org>

sparse warns about zero initializing an array with {0,}, change it to
the equivalent {0}.

Fixes the sparse warning:
mm/damon/tests/vaddr-kunit.h:69:47: warning: missing braces around initializer

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
v2: Added fixes tag. Thank you! 
---
 mm/damon/tests/vaddr-kunit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index a339d117150f..3dad8dfd9005 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -66,7 +66,7 @@ static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
        static struct mm_struct mm;
-       struct damon_addr_range regions[3] = {0,};
+       struct damon_addr_range regions[3] = {0};
        /* 10-20-25, 200-210-220, 300-305, 307-330 */
        struct vm_area_struct vmas[] = {
                (struct vm_area_struct) {.vm_start = 10, .vm_end = 20},
--
2.43.0
