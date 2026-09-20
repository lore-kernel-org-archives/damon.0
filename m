Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65E43DED4
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907124; cv=none; b=XPxJf2dukNnhRRVQfqQiIOyFt4hBJvNcBPWTZND83+drYcTz7YoR1dHIrF5biGrc1AAhLIg93kuAZbjYG9yEIDWhGiw1uOoF1BrJJj9GBIXmeGvvnGrWkA3aSyFUPlYRQnIvFRDvHWGxyN6cUOO00UsGl407OLqXAszte57eaPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907124; c=relaxed/simple;
	bh=OG5lCEUgYa4YxqH+9PDo4SHEg58BB5hNYIqEZJkrC9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gezyNnBrZHCilEhTVdpLnzpdSzgBGhrQD3jfZwy8USFZ0jPUWnP1JgOATFSOqfQjn3Dq/6a/al9fGt5IvLjaTM1C1IgBzI8qOsAvQY3Jf8iKjwf5TT4/Jr0EHsR89AjUdCSp6k3pAamjuP/2nKleEQZsAykVflKCd4DVXSodNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hV0sOSC9; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV0sOSC9"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so1328001a12.3
        for <damon@lists.linux.dev>; Sun, 20 Sep 2026 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789907095; x=1790511895; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bpdMVsVBLYjzWDTXbQjKSYrSvCe+sMnBTBU+TbdKtJ0=;
        b=hV0sOSC9Ht0jCCPqJHrknwXdOtLa7IxogejMy/ylbk/fhCt9CIleECWZBHm6XJEgVS
         gibBppJ2MNSAGLYMVLKWPscNNzZy6Sj0P+7m8ftlFINozTLQLfS6UVLBzfhLaVJuPtz2
         Oc5sT/Onf9yEcwxxGmTAYiHbN41QYOrbeP893oXsixWzu2kljWQXv9QmvYBf5Llt+BYh
         w1a9f8r9ku+98Egb7qkryiJBcawunwgPrUr140sEaGcQ/WobVRPhDZaqm1+4p5p6jLXz
         M49VNcfIEE8WwIKbygvdtizFN9l2VdX2VabIed8u2AOlGJxhc2ZlMixM3r16z/3qpIPH
         pzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789907095; x=1790511895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bpdMVsVBLYjzWDTXbQjKSYrSvCe+sMnBTBU+TbdKtJ0=;
        b=wcirooDiVO1hDSZ0I7JKIX3Yef1bQheGtHruSlBXcNvyYZftp7LZXQxFHnDOI4QGsD
         ND2XvBQjGbiUi+8giYMfxU4BiRHFlUfky2NJXdEIy4bujZ+Nim0xtLmlEP9NCYnHF8pB
         BVkrS/baA+t5kMBZfuutkwHnq7zM79S5rLZVf5Sdlo7syjfyrlzXWKHfJgxY1625WKM/
         claTs5BYRrvggebG8nDZm2LVVHu1ABh39ziHJfy4d5yF9RpluEbfIEbWoBakuTAg+r8S
         QIHijgrKdvmxemw5rPbEMIVm4EHysHE/WMS3bgiITHfs9nIyDjwW5UO1cVNchw3+In0H
         DKBw==
X-Gm-Message-State: AFuF++l1N6T6MloGCiW6H+isccaMXdNq2RjUYTT6RLulmyuDLFJGjVsd
	ffd/dTAtYxZ+KW4UyJL8cgKcFOzhvbbpaIwhhAJViunff/hd4rqomQ8=
X-Gm-Gg: AYBFou3EyMCeGrC3ZW5m9oYou9GxU6/+DGne8To4JTV+eis6TmCH8sR/Z13YP6TfVIp
	XZI479Pfse9nby/mJOpO23uqJSx/ruiJYy/+VnGlC/ehHSQO+9I28nDjgXEzCQwAVHy+PIJ86Bh
	hN48YpF6QWg1VFwUv6B+Kx/eLDF9NFAlh4apMEkWrtMy8Y19cQCgu8PCL1Ujr/Uwue46uV6adgr
	8JseRiJbLF4CI7mnRJRdcxYOWsrv5w2r3ZxVZcRSK4ajC2Zy79Xys18QNtFJKBgizDfuulyrO5W
	8opmgjAo7RFAYYA8AXiVw4XxY/X0z3gmlwGP8j64cLI0zohr4HjrXBu/cVHtEUCy+Hs7Rbr+gcg
	Q1NT2zNYn8QpwORCP76IN3nsJsGCIj79hJVITQzpmgpjO4m+BxIGbARKSi4OUb3bZ61oaDJp0Vm
	Gyi3hoTKOF4rq2NEfDXrHJzfHZHnjpSIaEf3VdHbjxdik+9HET0mV4NxQq3rCfg9rS9VhnYmW5+
	tmV0uaamue3inZfE9AYr0zZ0wU=
X-Received: by 2002:a17:90a:b82:b0:3a0:42a9:9c82 with SMTP id 98e67ed59e1d1-3a042a9a040mr609569a91.43.1789907095575;
        Sun, 20 Sep 2026 05:24:55 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:e0d6:4b87:c472:c9ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c3145e5sm9445857a91.5.2026.09.20.05.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:24:54 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH v2 3/3] Docs/admin-guide/mm/damon/usage: document the temporal tuner's quota limit
Date: Sun, 20 Sep 2026 21:24:48 +0900
Message-ID: <20260920122448.610319-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920104921.48065-1-sj@kernel.org>
References: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com> <20260920023111.2466265-4-donggeunyoo.kernel@gmail.com> <20260920104921.48065-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review.

On Sun, 20 Sep 2026 03:49:20 -0700 SJ Park <sj@kernel.org> wrote:
> I now think this documentation change is better not to be made.
> Correct me if I'm wrong.  If I'm not incorrect, could we drop this
> patch?

You are not wrong, and I agree.  Dropped in v3.

Thanks,
Donggeun
