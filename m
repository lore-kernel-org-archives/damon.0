Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013440;
	b=GcFeB06eItB2JmSUixUuy/Ov3hhWCtMplKR+9LR3rjFgQiFLmRe2e+j/wShC+DkNedZ9
	 aevKclAxr6IxHcFsoLNA8zVMEn4PUGDHhy7oMDj58SOTlaAPg4PoyeXz2sCGYjGogim3Q
	 FkCk83Izfk5zO9IDCdoFTwAlkKwyAmfVZQYjvZ8Sw+VGxo+trJPorNR4UDs7T6ECGt3ED
	 1Mx+DrmxOrX03zLpqfu7YzOYbztRNJ7Ik98YRhVjopOzHd0AfTrVF3y8aAc59OHl+1jeO
	 7IuPE+8905kdm/OvoeHJdCxOpQfy0sJSb68mGJ7tVcJTXLAyiTthN/hkl1jFQepR9sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:References;
	bh=fmsyrygG81C38l9zQdlGfkeoPAPtMMphWRdYuBnpfhM=;
	b=ms0JHEOsMyhX/5IpZighBEbVqbdutFkfDVCFOcserY7ojLVCVFHHSwD9aiRG1Hg7slPo
	 UgCEgN6v7tM6n+wmDiCUZgdPMCW+aqG/3rdSbWD34BY6BdvZnLZtr9USxolnT1nb9fL0h
	 VJkLbR2XUqm7q4ZB4hJfLmRrhbz3RXJeOqJP+YSoILJEyILsj3LPgKXL82Q7phTcj6EAU
	 E7T8MqNq9UzCYc9YJ8gKWi0iWGf8i/VIcjgQ/HQWnfyp3UFoKP7zB3NGZ/tvDnFXcbnJe
	 lnB8tAIH4NAJr9SIy5wCvIxa5EtWv0npvMptvNhkgHLNMlsWxa6vF8ExKBByiTgku1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NnGqoQe7;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24628606A31B
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24628606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NnGqoQe7
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2e538951d07so22077375ad.0
        for <damon@lists.linux.dev>; Mon, 26 Oct 2026 04:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013439; x=1793618239; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fmsyrygG81C38l9zQdlGfkeoPAPtMMphWRdYuBnpfhM=;
        b=NnGqoQe7fEOUlRNYLd8BO4NRcPoDIx1sIrDfm4RMPW5D6l1OF2GwFk6bKzINGfjD4M
         bhL76m7KE/BTFPBRIfFn3xf08dZ94b5ww1PNrOwe9UeqFF0omzB6D1Xl+aPuoo5mmRi5
         YNgeS6ZIYV++sFqyhCtBP1TwnxCVQcqXPnSWpwqXWZ7I7JaxmWuGgyebjvKMCkWzn3AG
         JNzaqkRr4sBuKQXHcAxtX86cEtftCTbgfEpxYVSj6Ij3m1Y+TFzeg0zdRue7J1A82jVl
         Jfk2qB8ZSVBjhD0R5ST1gowvc/8ilqGSdJem3HojN2CRkJPhrYhoCkdFaPGlSuq3m50h
         T1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013439; x=1793618239;
        h=references:in-reply-to:message-id:date:content-transfer-encoding
         :content-type:mime-version:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fmsyrygG81C38l9zQdlGfkeoPAPtMMphWRdYuBnpfhM=;
        b=i7bNOo1AExWm17NO68C2ODKw0KPjE7b/Gmo/1tvUYVQMQjGQX/n88HSfEErotxgQIV
         mBLEdev1wd8sOgcMUL6xCd+dXftVwAnmpmm8S8H9Lbvv+CdX4KWiu5eHkuTp8MG6lj97
         k0FV/DB+2/W/ayG5MfZp2Gi7dfKIrR09qJSi03RWYcvY89u6cAwks3zFUQIyWP0tn7aJ
         roAnrPkksnx77iz4pbiTsmeGSk7TeKM1b9M5mADNeWXjbKzAI4zGqvDxEQDxwFucgHWe
         PUzX5BsflgQsedAcfmqkRVqH8BgZo24zwgpVLjC7STNlpUWU8rDFcyqxyH7Rc2pxyY9U
         GuWA==
X-Forwarded-Encrypted: i=1; AKwUvBzUni6/W1O8t/pmncpB8CwWFC5TRBQt+ZhKs1kUyY7t0ai19nhj20xbxdV5uxEJmFC5Qewk+w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJraR6R2NVI4pmK5zT+bYIIuoEOaHKfbvNLVcOiTm5dW/7e1dwV
	ioYTpxTMo4Q5Xu2z9DwhWYsnRjp0/KmKZ8G2vaASoatpH2MxhMKsLk1f
X-Gm-Gg: AYBFou05xLXWZHR1oCJncfYz6Up4BadHGSDEanFbOJuQLT+seSa2Q7kBKVYvUAv8TbO
	Vyii/ByiwYcWFGAICB36AZWXfkenIeDPpUCiwopb2IOBuHDnElVhGoaSJnFP57ABKWIKHGQi3Ex
	skpHcBstEe90rAQ6VcH4Q+ZHxs38AnShNNurdkqz0lvML5j9cez5lG03NlUCyD8lkrAb9wEKjUt
	48mZhclKoPAQKzP30h9zkrqbJo7M4D2MXMa7dHqZBJMLdpuSS/vGoH39YLPkrhd4mN/ToylsS9Y
	/KJw4H3L7hYqLA9OdUj2Gmv5mRlWE8xcg9zsMsETT/olPqQ1/fnQCj1xACwWgCFNMRyaq4RGgcl
	lo+AiPWoHYlSqjyGnTahnG5Rp2W+4NedPc4B9fjVsAgoHzL/jYPhkrYmsuF+8F7Z27+SmRjdQO9
	+4elHRQ/8viaN2zfDFWNlLM5BWn64OU9iPDY3E50hQkCJZc19Gz1usQWNuHBIgnp8MmX4249C93
	UZO5VOgMyeagML3rFLuzHZNwdYpVn7AjdlUBRvZ1XG5cPkdSIsyh7MkO3wffu0q3KWK5fzh11ak
	Yd+WXU3jnqX+kuOVm0ACDyRXxXx/aHYYsz9+POyaoZ8hySKm2s+KgA==
X-Received: by 2002:a17:903:3905:b0:2e4:aa09:fa9f with SMTP id d9443c01a7336-2ea9c84b404mr55890135ad.57.1793013439353;
        Mon, 26 Oct 2026 04:17:19 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1df35asm14878235ad.60.2026.10.26.04.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:17:18 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Manuel Ebner <manuelebnerli@mailbox.org>,
 damon@lists.linux.dev,
 linux-mm@kvack.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] Docs/admin-guide/mm/damon/start: fix grammar
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Mon, 26 Oct 2026 22:14:33 +1100
Message-ID: <179301327249.2.1796164575094900927.damon-docs-grammar-1@gmail.com>
In-Reply-To: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>
References: <179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>

Fix a few grammar slips in the getting-started guide, like "make DAMON
monitors" and a region "that has not accessed".

"The line of the commands" used to be "The first two lines".  With only
one masim line left, I make it "The first line". 

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 Documentation/admin-guide/mm/damon/start.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index d98b0eb8e771..a83fcc2265bd 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -63,7 +63,7 @@ the execution. ::
 
 The first command of the above example downloads and builds an artificial
 memory access generator program called ``masim``.  The second command asks DAMO
-to start the program via the given command and make DAMON monitors the newly
+to start the program via the given command and make DAMON monitor the newly
 started process.  The third command retrieves the current snapshot of the
 monitored access pattern of the process from DAMON and shows the pattern in a
 human readable format.
@@ -71,7 +71,7 @@ human readable format.
 The first line of the output shows the relative access temperature (hotness) of
 the regions in a single row heatmap format.  Each column on the heatmap
 represents regions of same size on the monitored virtual address space.  The
-position of the column on the row and the number on the column represents the
+position of the column on the row and the number on the column represent the
 relative location and access temperature of the region.  ``[...]`` means
 unmapped huge regions on the virtual address spaces.  The second line shows
 additional information for better understanding the heatmap.
@@ -95,7 +95,7 @@ monitoring results to a file. ::
     $ ./masim ./configs/zigzag.cfg &
     $ sudo damo record -o damon.data $(pidof masim)
 
-The line of the commands run the artificial memory access
+The first line of the commands runs the artificial memory access
 generator program again.  The generator will repeatedly
 access two 100 MiB sized memory regions one by one.  You can substitute this
 with your real workload.  The last line asks ``damo`` to record the access
@@ -170,8 +170,8 @@ set size has chronologically changed.::
 Data Access Pattern Aware Memory Management
 ===========================================
 
-Below command makes every memory region of size >=4K that has not accessed for
->=60 seconds in your workload to be swapped out. ::
+Below command makes every memory region of size >=4K that has not been accessed
+for >=60 seconds in your workload to be swapped out. ::
 
     $ sudo damo start --damos_access_rate 0 0 --damos_sz_region 4K max \
                       --damos_age 60s max --damos_action pageout \
