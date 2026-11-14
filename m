Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640252;
	b=gNi8HQjnSi4df59tiaudoqTxLfYP0w7aXyISHfuu5ITeWuvF7AMg3QHCe/AliCf46Spx
	 M03hIFr3gzxyJZ1x6dvn5kJSfrd915xfflZJaQpuOMM6fuviTghGiMhOk2JKijEkBeA7K
	 gF31jxE45jtxTcD62IDpRb0lzTN1C8zpG3GDNNEj8wsGihFdLSOSFf8LnNgw3pcxn8P0N
	 SOM4IDZXKtjKAc6s4bE1RzejwfgQdefMWB3j0zuCbKC0Owq7ECGWkjPUKttGesA08sQpX
	 Nn471+haB30dfzfsrdRG4I3qY8vNfLF477cfVQann6hlR2K3SE9saVZqdW9Nd32amVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+HAKXNFyWuVVus4jyGRYSZgEnC6sp/o+JpWnVYJ3k8U=;
	b=0Ifv+gYI+nOLGf+8UaoR/VjPxb7+g5fe365Bg/bYuvDTo0ZejQdYh0Ups7/ZVDGqXGhi
	 s6qtdKHqGf2xHjzH5Zxo3vSqTTPi8KZCUYBp+ICzpnc+UtOElaHzcUWS0AwpOHQWnWX0+
	 halF2+f6QCu5AfV2Qi4OtKqQnOVsZEOBw1kwPu99z3C/OToHkgWHg6AeYbEj4KuSKcR/w
	 JqLl1LF6dbaZXNn0+HDkql8d9siBohU/d3IjMI0bCzAw5bRHJnFqf7bOrmhsJ8Dx1Kcoc
	 513uruYu0EA7cClb8iaG+eEPqmKNplIfKZ+0Bkeipk264MwwTlCFrGDIG+qsRlX6c/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=s38phKjG;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36D5606CDAD
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A36D5606CDAD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=s38phKjG
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-55b8cd4e2abso17327971cf.1
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640251; x=1795245051; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+HAKXNFyWuVVus4jyGRYSZgEnC6sp/o+JpWnVYJ3k8U=;
        b=s38phKjGjPup5LXNJUW/uya+GQoXUfpzM6IAve6DcKolIOCXSLnP8IIwiqM0LMKGEp
         bjNvdWxA/jO0jmFV9PHpltK1RF6CtEpNDehChXYmBY7gMBWlzv1lTdCqIa7WlIrbBVoe
         dl7FQUZ0A17iD3CQ0oL3i1JUyQXLdoUBsPQlyOBsvNvjJ+xWdZI0kWFdt5njgsRW+Upv
         /nHV0UhbTEGpNAyjRFflohtilaAeRCq4McUGrBPSKqWL6HeotWhSYfpYvS0u8sISzXTq
         1yZ6t+T0J7jhyXStoTuY9QmphLCPFABVqD4IlIv/vZcrNuzloph0CQnEm44aN0NcyhPx
         GJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640251; x=1795245051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+HAKXNFyWuVVus4jyGRYSZgEnC6sp/o+JpWnVYJ3k8U=;
        b=RqK9lz/Imnp6yIdo/1ac+jzmva/7IC7/+6m68nCVFiIQPLErQrJ86yal5qSLdEEmgE
         0R1rouRXhYLT9n8g7akpPSzl6rFx111QhReceRclZ8aO3q4L+aqMlfhLLKGDAqLtIE0G
         Co6ozM7MS7WwJwjhoyLVuoNfe5MM1C4eCEEYd+UO+fi9pdazIKcZJx8zX3pqtnr0SRn6
         F6Qgg3VNCORgHO2uBajw2MXJnty0gpyN3CYwLJlEK9Gm7kwkvW76pFFNeEYvvL2mPECj
         7vyYpZUgURzMUHbzPz4ex6xFn+yQpPDE11qnNuzr35jb+8xiGxom/isl7dX2WDg3I0XF
         wRAw==
X-Forwarded-Encrypted: i=1; AL+hErE5z8hcizcO97e29jafcP9EXyVjG396ZNFQvRHL1hKrdiQIfpTeVYIWurWsffSk8/kVi+1H9w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8JMoVR5bZ6ABPXUaLUmNUMR1H6s5nL2VF+ywmMP3mPGch8LBUq
	n+ljQU2JqDUbCxbj0WAUaKVPiFW8Pela520Ftipf2gpmobji1vKPgXnIWpirXEIY+KM=
X-Gm-Gg: AYBFou31Fo8r75b3288nsFFN0PiyeiWOYXrckBOVj+fjoTLE08jrLmROLQ924HirpOS
	7J3qznWwAVJMzWXiLHMoK2u99sUOuSr97MetAz9eByOMAnca4BFJyB8JfiWQD/vPoRW3uEezeYX
	XPeZaik5qZarnuW3fheEtdgA8BTKHF4I1b5cul5aOBcRQ4MwM+lInKQVdEyHAd9bkRrJLrEFDpO
	1BoLqYC/O9NEOOrTy5kObCPjoBIXH1bLJpWRdhz1Oy6DLCzddXSAN6nUYNNM4AlC5AVsQ45Zhor
	O/MqJ7FPx003mCcNrw85CBJ/amW6+PdvviYnUVyUU1hGT4s0tijypdma1GluMtwSoRj+ybXSSlO
	dLFzGuwFb5apAk2G0vdlyEmc2/kwsyPlfjVqQu2zT2DilBA3/nj6bxZlgnWJjzAtDURlL5x4MxB
	muaeospGYbGHABKtbjXpmVfqgLP3tGvZs2xvGQIg8gYoLqp9Z8UUT8fxDtyEs9QWgnGyVb4BZjs
	3fKN0RKAxautHQruDmuo0Sfz8HQ3A5ZHVBlJPQDXm9lssj+8qBkIn4p7YrI+6g+sDn1GRagZVUR
	hEWhyC8JOelq8b6GG8ceBwFVoYPmsWRz0/4s++e9tzoqZG7qNkgVlopxBQrCk09abRAsRSlfE0X
	+nIBRP3iqjm+W9A0=
X-Received: by 2002:a05:622a:191b:b0:535:a5fc:3b58 with SMTP id d75a77b69052e-55ac8b9ba4dmr73074831cf.68.1794640250752;
        Fri, 13 Nov 2026 23:10:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:50 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 22/22] nodemask: remove the now-unused first_memory_node/next_memory_node
Date: Sat, 14 Nov 2026 02:09:59 -0500
Message-ID: <20261114070959.3490008-23-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
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

Both helpers hard-code N_MEMORY, which says only that memory exists.

Every caller now names the state it means, leaving no users of either
helper. Remove them so new code has to pick a node state explicitly
rather than silently getting N_MEMORY.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/nodemask.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 7ace610bdd654..eea0ff7601303 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -457,15 +457,10 @@ static __always_inline unsigned int next_node_state(int nid, enum node_states st
 }
 
 #define first_online_node	first_node_state(N_ONLINE)
-#define first_memory_node	first_node_state(N_MEMORY)
 static __always_inline unsigned int next_online_node(int nid)
 {
 	return next_node_state(nid, N_ONLINE);
 }
-static __always_inline unsigned int next_memory_node(int nid)
-{
-	return next_node_state(nid, N_MEMORY);
-}
 
 static __always_inline void node_set_online(int nid)
 {
@@ -509,9 +504,7 @@ static __always_inline unsigned int next_node_state(int nid, enum node_states st
 }
 
 #define first_online_node	0
-#define first_memory_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
-#define next_memory_node(nid)	(MAX_NUMNODES)
 
 #define node_set_online(node)	   node_set_state((node), N_ONLINE)
 #define node_set_offline(node)	   node_clear_state((node), N_ONLINE)
-- 
2.53.1-Meta

