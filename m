Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792628438;
	b=OmHhz4IhHsIKrV5P4eSrj2SA40dG+4RTOh2EFu8JZdMlL9zYl21B3Y54maWthiiBZeme
	 122uhtdMzadfcqhWQTYOGpP3PniGSTk5wmAxauSzBq9k6jDoqpGSizaA7EDP1534EWjVT
	 90Ux7QJHwWAxV1O7qpR2+XT5N/fKUZ4sjIrsTkqWKik5neDVEzseQl6iKi+mmmya6OC7g
	 Kbyjlf/YDG7/PohCmEdQqq1DQ8adn/KRU0TY0HfQujM9ASlZ0PiypE0sPpYf+CeorFOxA
	 vdANX7Ik2n21oVwrS+reZoL0LsC4h5la7AkZos6X4rrUblrrkEQotZGJ/4JOQ0LzeYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792628438;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=U160OhCDm3caKtoLaOhiSMfGfQJGF31Y72hqDHrZ/jc=;
	b=OQiaTKTPyaWrAY5KQaKU6wjkPUZrwdS/gNchvOeMGdJ7C56NtQcZnjCmkpCSjF0vPjv4
	 u98uVTv740DFrksJgZZpJNiK4Pp8BKLQTfipB9pSeHoTYL2y4YQbNATT/AhouVghTK58I
	 PhIFp20+8it/H9zWUtUVPyO+h60gHDSF8EcYPjI6lw7j72N3CYMraTQ1EDJ/R7p0payYS
	 uiBPIKmhmZuz/hFNNMz5+s9OS/Mv509S7jcgZbTcKqXWlowBI78n5qmjLbB9MZ6iRI3tE
	 ivPE4uQLGy3NyWEUubzDne55BRzOSsR+3Ofm1C552Q5/HSPX0+aawkaHEA85rgkz7cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=llNDq7wr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E9606A319;
	Thu, 22 Oct 2026 00:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=llNDq7wr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4D11F000C1;
	Thu, 22 Oct 2026 00:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792628438;
	bh=U160OhCDm3caKtoLaOhiSMfGfQJGF31Y72hqDHrZ/jc=;
	h=From:To:Cc:Subject:Date;
	b=llNDq7wrV6MxufRqHZpgUFgyLDnog42KLTCk+myzhfYCnHp0LR9CjOgCSrogX1yiv
	 EieROOVa3zg7L0SXKg2k7tPgkOleIWBTfCF/HOfr6HEMwEofE9KNVSxNGV7XqIUR5N
	 Ph8dL/khLeSJQ9cUhNM5YSErZlyDlttsvNhjakXtefmGHbgr6aEQuGBDOD4FWqkjz+
	 rmD99yYhCJwSHjSITfzzx4ELi6T3o6wxeWML8OSwvG7kNUxdn1aUdammBt9NopKs9r
	 cOadhxhASA81GZxjsZXhlLf/qCZlouu+EQu6TmL0DqfEVWswxtFrpf0iOUq6PsH0V3
	 10eEBEMrZ7iiA==
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Beer/Coffee/Tea chat reminder for the week of 2026-10-26
Date: Wed, 21 Oct 2026 17:20:30 -0700
Message-ID: <20261022002031.87137-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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

Hello,


This is yet another reminder of upcoming DAMON Beer/Coffee/Tea chats
(https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing)
for the week of 2026-10-26.

As usual, we have two time slots for meetings in the week.  Next six time slots
are as below.

2026-10-26 (Mon) 18:00 PT (not yet reserved)
2026-10-27 (Tue) 09:30 PT (not yet reserved)
2026-11-09 (Mon) 18:00 PT (not yet reserved)
2026-11-10 (Tue) 09:30 PT (not yet reserved)
2026-11-23 (Mon) 18:00 PT (not yet reserved)
2026-11-24 (Tue) 09:30 PT (not yet reserved)

Please reach out to me (sj@kernel.org or whatever) to reserve the
not-yet-reserved time slots for your topics.  The reservation is made in a
First-Come First-Served way, and I will send a Google Meet link to
reservation-confirmed attendees.

Please note that other time slots are also available on demands.

Shared Calendar
---------------

You can get the schedule via this shared Google Calendar:
https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t


Thanks,
SJ
