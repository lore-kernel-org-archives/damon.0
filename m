Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF03C07A
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275602; cv=none; b=qiTPcDFi40rhW62CRWgrcnf7PkevFfXHFesznn3WQ8BIXc8WCKyjjTFR03i1RyX3eDyQxVoPds638m8jODZtgZo1HgkXEZRuJ92FXeFdzEKOIihNUJ5WlxVAzERH0AjEJHK0D6ZLVPFRC7+i3AQcXoq0tBLFSP51NOtsik4p41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275602; c=relaxed/simple;
	bh=OUQvRGEelBB7L4nOz1zfbVEpVfhPCan+9hgolp1wUaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVa3t7COHhRPo7FvDvtG5WBCKtjLIH/UvvrNlubTTDD8ESDp/ULFBGE3U4WrmQEVCpKZt0r66GxCWEwheeL8krt0fP9L6zgOafM72NLlreTfw3RQRMs4aNkAWyuBVHrhJjRnQbTdlbF9i3Uf3CmX+oIN2YMxjsmYktV1Lexp+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0dbhedZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0dbhedZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad617d5b80so28046375ad.1
        for <damon@lists.linux.dev>; Mon, 23 Mar 2026 07:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774275601; x=1774880401; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7v0kKo5kx/NTKypqvvw5WZo/TwKAYeoO2unauSZDIU=;
        b=b0dbhedZtqrnz9jnklWj+ezBVd2yiHqjurw0iBDBhoT+dBBcfXqUCymoTEqkjR8QbM
         sBuwAO3eDoSakOWrHjL4N+B0pijQRocn9zu1ZX1BrZzYJRwpyIg4bobH0DRdsB5C8fG6
         TLdlmIVFj2JZwsk9Vj9K3ZzCJ4o4TGYwA66klpBDWKkZ0LMBVTyP0Wd7KUmloh+yrp4B
         KScUoDltutbw6Mbbfe39/qJKOYs/CsGP9CF/ttDFGP2mUGHJZmwYyN8pLp8mm95yj47S
         N/4iNHCU0eI/virYA0QRqEaCkKk9QOB6RCZFRuhMHlpqKIzn0kYFsDGE+mx4Uuq8pxLG
         /5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774275601; x=1774880401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7v0kKo5kx/NTKypqvvw5WZo/TwKAYeoO2unauSZDIU=;
        b=AIuPjvUBw9sjQhprfFVniok0J7XHQE1qUHLr1ClAsnjbn/7wVtPDTYUQA0rWxUr+6m
         UV17S8I3jPhX+qpu2IWQorUYAZebAAOZp8eMarzPPI+OkzSr5SjQIdxZEm8IuODYiiB8
         iPTjGE95AOqHSgW+TLhBYC8ybmAXc3ZDHWOmF9vjMxU5tYDPjhEGBdpkKlPPeZ6xKk2j
         b9p1L+ywjWZ0wZvAJZlvJaNJecwF3irxlGBkvLNL2mTeIrxMNHUHBBGQnBKecVhFD7nX
         1eSuMwvD9fP8+537nYgFJYa22ecWvgr/d2TtX3e8tJNpVnh3HBIsSyPd6jVcoglDTcX2
         ufJQ==
X-Gm-Message-State: AOJu0YwV7Ysu7cj/6MsKMIg6AtQ29qrAoN3Bxvi0KpkE037S4/MwT2zi
	V8V9XXKgjWSyRM0qpWcBFEcHGcQkMEEdvgyYlrqpq9B+iBihCL1m2g0E
X-Gm-Gg: ATEYQzx4qut49PXPRFxmOqFpVhUL0TJStMnm6xakKcpC2drbMMg6LShp53Z+gyJthi+
	HhLPV5ICCC7KYE9j8EAC7iEuB/peINo5oZfHCC2KglLduAWIWDB2e9JQcoJ73TNEu87sBtsqyfS
	/jfv43fyj13aAddpfHQx8uKDyAQcRgDke0kXce9H/3ZTkuEHxTNlfKrNtC24TEKmh3DGZh4OQaT
	+DTABTJIr/WgwPgMj7W2GefFH2FF4YkGySJTqAS7ZrlSg5e4sHNxKTaTAH42MTHp0HkztCc1w1A
	noWZ8JOpx7O5rTPkfgXa92DcfMCMbzBSmaMw/wpudwgy27MYeXTIjaZBllIhP6zzcVq5I3MbHsE
	PQzeLHKO/sXG7iZAdc4IdJvAn0HCgUPVnDHW/23F/ErVkZv2uYWKPO90UR4mHRG+tc+7Lslz2I5
	6IrPrAATNSB94CzTT0AhKL7j7Vf2A=
X-Received: by 2002:a17:903:240e:b0:2b0:60b2:4dc with SMTP id d9443c01a7336-2b082750c20mr127256235ad.15.1774275600873;
        Mon, 23 Mar 2026 07:20:00 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836747dcsm107209275ad.64.2026.03.23.07.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 07:20:00 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	aethernet65535@gmail.com
Subject: Re: [RFC v4] mm/damon: add synchronous commit for commit_inputs
Date: Mon, 23 Mar 2026 22:19:55 +0800
Message-ID: <20260323141955.20535-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323072724.15942-1-aethernet65535@gmail.com>
References: <20260323072724.15942-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

Follow-up on my previous email regarding the locking concerns.

> I admit I don't have an elegant solution yet. Here are my current
> thought:
> 
> Add a timeout to wait_for_completion() (e.g.,
> wait_for_completion_timeout()), using 'damos_watermarks.interval' as the
> upper bound. This prevents indefinite blocking of 'param_lock', though
> it still holds the global lock for up to several seconds.

After further analysis, I realized that since both 'commit_inputs' and
'enabled' module parameters are protected by the global 'param_lock',
stopping kdamond gracefully (via enabled=N) is serialized with
'commit_inputs' writes. Therefore, a classic deadlock scenario should
not occur in normal operation.

However, I'm considering edge cases where kdamond might terminate
unexpectedly. In such cases, commit_inputs_store() could hold
'param_lock' indefinitely, blocking other module parameter updates
system-wide.

To mitigate this risk defensively, would you accept adding a timeout to
wait_for_completion()? This ensures 'param_lock' is eventually released
even if kdamond fails unexpectedly.

Please let me know your preference. :>

Best regards,
Rui Yan
