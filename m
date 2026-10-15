Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51A4C9E01
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063463; cv=pass; b=DgRim58tej1M88pvPU5Rch52gw2oUab0egYdQor7JuwNXw7qNS7Ard1fRU7a1+HPfEFTJvjsYvIMytPqYgexxjogez+p+4cfbjsmjCiEXc3kGGU7HPck3EaM+/N8dZ3+1n9PO/GNP57sL/PMoE3lgMvXXCLBO+dSE1V+tRP9PaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063463; c=relaxed/simple;
	bh=XVMTbGI24hbajbBIxXy0Jvn5BAj5rjBFBQOCI/BpQ+U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fyjO67jRAa0ruUUaVMXtktpx5/K1z0qjhWmFyGh0FjSPAbFbzVIYuVBqRFJw7IiSeeVZFBRRvDI3BYf0nLGko6RwvV7mG+zvYAcZ+/9HKLm3bj2qUMl3VpbKJSSxkPE5qLGWoxodJ0hkxUx7cE2MroV5Dm6k1xX/iVxNxaO1TGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nd2tUWmQ; arc=pass smtp.client-ip=74.125.231.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nd2tUWmQ"
Received: by mail-oi2-f9.google.com with SMTP id 5614622812f47-4f4f77e92eeso733921b6e.1
        for <damon@lists.linux.dev>; Thu, 15 Oct 2026 04:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792063461; cv=none;
        d=google.com; s=arc-20260327;
        b=KygYsQ6neohRRWnV01EtQ4Gv529QnIuADuFksN4Qmnv9XrEBcfNDPbtEVlrQtubMuf
         mk7z3nwPFOgJd4q3nUXYMYxKKcS3elrlneUhBpLv4/jDll0K8K3KnRj28gs3TsIS1qqM
         /qxzeJfmhjOlSadmbcYvtR1AJsIq8dOCCBYZytF/wWpaWGiBcwfHqLUmQLPsXCjqLuNN
         Sck5j44Q4bZ+MdsCZR4IZpcwcYBRkGiZCBTNM6tWf5TEbTYP8HCH7d/692LgcK+xDXbJ
         COwkVybn2HH2jpYGpi8VOGJ0p1Vkf2MsK7qkrYK9dPxYyHYL6pGRHxofFtm3p/HqpRb3
         4xTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=toN6NfvRkfvzS3ZSAY9pfVPprxB1LDrTzbA57aszDio=;
        fh=r142B9S1PknqgC2h5MW8zIFXCetCva286MzpouUXBL4=;
        b=SLgLfpkT9js8BvYQKa2rElW2A62cr260a7/BBJ86OriACtwD//AaRrp/qZXykcjfeC
         iBL6Kp3enJu81oMJ9LLe9JB/xXM2VdhbBfn5C7JFQPl4DtHBJUkm+gLMn/bDi0kW1fkk
         M5cahbbDTxU0Tba067uSWz0/gSnvE61taix+H49FuluQ/jS6O9S/7ePrI5Ky5r76t0A/
         y2J4XoXcwOjt5nM2SQDKOKpvdI4LwX7Z0Cp8Llkq5CDxQ4biLz/aUOjhkRqONw0/91yI
         pYDhzVEjgHja4bnWsMjFkcE7tQef3zxvJx4qC4Ecz9AgJ54xW7KzuaVwJJs7WwZy/0ws
         UbWQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792063461; x=1792668261; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=toN6NfvRkfvzS3ZSAY9pfVPprxB1LDrTzbA57aszDio=;
        b=nd2tUWmQ9HotHTlcTbNuwXvaxo+L1YZ6ZELXcrxgzz8SUKTQ71RPd5F3PiZOgkMY2Q
         DbzTjE6vvkEpP0tjkH2po23iaWzMZ4sm7VjbzkvZQwqv+WTX/dgMtwtrEuMmy4d+KG+Q
         vY7BUGFOis7y6U+48qaHUCzo84dFwyyYBcVwxk2eAX42kOIOpr8XkXFlHgtKWPsAJfYq
         OcNvQNGsTyQhW7Ys82OPAM/tYvW3n3cNALA+8yyuDiQlVf5zwgAZOg49yVkm+rEPRw6t
         w/5cbeKfw+pc8dLD3Q4c2yLNHfNXInxbFEa58huAXjX0QU0mayI6ShmPd+xy1mqIV8FU
         B8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792063461; x=1792668261;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=toN6NfvRkfvzS3ZSAY9pfVPprxB1LDrTzbA57aszDio=;
        b=K/kInbBncKaYLer1+Wdw+8QQJm2KIr5anmlz59NVQvYq6aRk1PRsM4A+2grkxQB0sy
         24HFiYGcyWEKiD0JAlZjL6wiQK7usHqXT2oidZjpKHCZ5tAIMRT0AG6D2ZHIEWoyIiWH
         NuiHdZh/oUEihHgsLnn8ArVZQsu8DlN6zm3M48+UWEC4C1ngSavaAlaYexVlb9SNiZEh
         GXTd445ALzJE7VlMqmpA1EX9IfIoFEvnYTs5HAnOzev+fmXgRI8k7JgeYWk4bsdvwvij
         MQknM7+mClx3v35adqkPwCc4yzl+joribqQSu1RFTCAgDhEcAPcQqdu359pR2LyoZezp
         sskw==
X-Forwarded-Encrypted: i=1; AKwUvBwv4vlCFYQz4n3NE0Ogq808mhzAgCHHUldNb+/W6ZDCvktcDsUZzm2rEb8yQrvw/yjcUwluEQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJaeiVaxPXCDwePJO61qqyonaS0k1vYEXgXyFTQ/KPpEwleC9nG
	BccuwkCq28j0zM3bI76c4qMABdyZGlGt4OlrUjLdY5oXSEEMAXNZB7QGgx07N+S5bsLE7VXqlt0
	LSeJU3ITxIC2wqwVywcEIqVWV3ZZSJLg=
X-Gm-Gg: AYBFou0CZy84eavQHtPCz7R+73zYjdV3W06EwSW6uj10jOaCbroCncV3qtYkrr4M7qx
	BBXnAmogneI/amRg/d5eIBJUTowwIOYQlb0OAME14n1DWH0od9jBEdVxPdZxR5upAe4HuFd9ruf
	z5zqAGjGHjy01wjI4vI6I4LF+3bI23b+WPihSKt6NwhkKCRyJ/21hayQpd1/txRkPCuo9tplBwN
	cN8ek3ZtKFlYASmd4MtEmmMA+EpmtpBBlpW7bUXG8VKbJMpljVDmnidHoAFCjeoO5YibHlYshl+
	9Y58/RtYoZTr7Rtx+ne2Ge5QIl19vA2GAvkWJalv8S9xpovLe+p6hbHEo4jx+uXyw0lIjKTZdBU
	EivuWLBCrZw==
X-Received: by 2002:a05:6808:4fde:b0:4fb:a7f3:420d with SMTP id
 5614622812f47-50c57696145mr17825753b6e.48.1792063461122; Thu, 15 Oct 2026
 04:24:21 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 04:24:19 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 06:06:51 -0500
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Aveline Noir <jm5905938@gmail.com>
Date: Thu, 15 Oct 2026 04:24:19 -0700
X-Gm-Features: AclHuK-608mCEKwpz-MUlsDmIU9QQ8jGf8QLRe02ypGSFraehbwNM8aN2ipTdn4
Message-ID: <CANOyQmFPJt=-=hJh9Gt-FPG6YiyeidyfUbnW0mF5bSmJ0m7P0w@mail.gmail.com>
Subject: [BUG] DAMON_STAT: 32-bit overflow reports wrong estimated bandwidth
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On an unmodified i386 QEMU kernel at mm-new commit ad9f2d463666,
DAMON_STAT reported an incorrect estimated_memory_bandwidth value.
CONFIG_DAMON_STAT=y and CONFIG_DAMON_STAT_ENABLED_DEFAULT=y were set.
The guest continuously wrote one byte per page across a 32 MiB mapping.
I used QEMU's GDB stub and the matching vmlinux to stop just after
damon_stat_set_estimated_memory_bandwidth() stored its result.  At each
stop, I traversed the same target's regions separately and recomputed
access_bytes with full-width integers.

Three nonzero callbacks, all with aggr_interval=100000 us, showed:

  access_bytes   independent sum   stored B/s   full-width B/s
      33357824          33357824        31079        333578240
      65200128          65200128        25244        652001280
      41152512          41152512        24303        411525120

The final sysfs read was estimated_memory_bandwidth=24303, matching the
last stored value.  The independent region sum matched the kernel's
access_bytes in every callback, so the sum had not overflowed.  Each
full-width result fits a 32-bit unsigned long.

In mm/damon/stat.c, the expression multiplies the unsigned long
access_bytes by 1000000 before dividing by the aggregation interval.
On i386 the product wraps.  In the first row it becomes 3107979264;
dividing by 100000 gives the stored value, 31079.  Full-width arithmetic
gives 333578240 B/s from the same inputs.  The other two rows show the
same problem at the callback site.

The workload is synthetic; the test checks DAMON_STAT's arithmetic, not
the accuracy of its traffic estimate.  The i386 config, guest init,
disassembly, GDB probe, logs, and build/run steps are here:

  https://github.com/jm5905938/kernel-mail/tree/195d7017352a3d0f4a0475b98f3b03650f5c14ea/cases/2026/damon/2026-10-15-bug-reports/04-stat-bandwidth-32bit-overflow

Thanks,
Aveline Noir
