Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B9730C345
	for <damon@lists.linux.dev>; Wed, 22 Jul 2026 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683437; cv=none; b=Y6jME1Szepw1/D0JhaqhXCNYNm7WI+BoIhhY5ajTGOGqpNTSoAANsIQpZVPG/9+sLasJ0zsbZVxMA5dsydh+QhGBY0mPxjmILiHkT9eFqy8J0bY78rlgjCQslH7+tIDC3qXI0MvLOAB7FyweFX1W0AwmD+GgVf/LZfxB8YUXMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683437; c=relaxed/simple;
	bh=B3++cTbdJ49038jePsljx+Gyp4sIgoEM/bU7x9eRQSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktjNMeQwsKQgqze4v41dpFOmDiyKMCuBks0JOtYEPw3+ZO7l13bwoId8m7EbTX2+WSAOvlVWPHgiZgHQrMEb/q2H9qURDbcCM4NE3eTnu2HZX2Y08HFiTOPKneCOeSL98C7SLEQFSCra4J4Jjqtfh7Dalv17qPevqSMZjoTB1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoSoYBDz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoSoYBDz"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso5800080a12.1
        for <damon@lists.linux.dev>; Tue, 21 Jul 2026 18:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784683434; x=1785288234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YbFXTrauONRUcQG2aMTBcn7xFxe1QUlq55ZfdY6FsS4=;
        b=eoSoYBDz/byCndY6tD1d2hsrYs8/o9IbsNhaz86wf71gx/IpJ/C3PJmdaYEhHiE+GR
         G6RZwHFBrveY17W+gi4BfRCIGAUTTKyZ+mLoY9G8tgyNQZ/bZWU4hVldP5cooDqiGnBQ
         MlkIrIgcZ0jzQfy2p493Uy5PjbCE2i2fXxCvVv149G1hO9NCd64kmHrJsHqsTLWhoimP
         pAqE8Uo2xF2ztr3X+Sh4iQrJ7m5cBO1p8j1evkJnv4SrNf9/LT8cS0UyWkK6fIz4PFd+
         OMrZh2tPN0WdVI8MWW5QRAsftt97LpFT4AThGwGE4T6aUvWcwmbL4H+U/yNKkX4Ed92y
         xLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784683434; x=1785288234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YbFXTrauONRUcQG2aMTBcn7xFxe1QUlq55ZfdY6FsS4=;
        b=WrFzSSSc3l139k+g/vInDsXqapOTKig1nLipE1iG43yXQN8DMVZlPPRGHzNA6YdBcM
         piQpbqtmzIkkjtzmJ56S7ieXDR97St9/jplZnlXdA45hT6dCW+It51p84AGf3Y/9dy+e
         +QY/hHhGGHhPYBOxFZpADW4LjqY+Igg53VH+THdsaaT7f0Mve8SqFj2fGVpAOMEhCT+o
         e8z4Sx9pyjWdbha7RTdiOHld0jjr9KVXqUgC4I8BvjFBvdDbd1ajqRMQ6VBYAm/IGuG/
         woS0eBxuSUVDYQg/ZISb3Ip1e+9EDSWj5vCSxjcx7ayaY5NRcoLq6MOb9MeTAe9EGDj7
         LejQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1N5fHQUD4hTJokejVZBu34VMoeugUth0eAt4ScrdvMjuIQf8IZNifgnuqODvOl152xAVYLw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1mwWNZBB9+FHEmfFoy+coufoyBrgTCmpS0UuAKNIHqA1WKAs3
	oVUeWsnLrMyMbEsuWXdUvqQ8yNLy+W9BFfOnWiXJT6scANWWpSFDgunTdY+6wfYhL2/UXQ==
X-Gm-Gg: AR+sD11McuOALU+jotBnXB+7uTdQTkTuFHYEtE37XiFndDFudRTcg0tzQ5HwTomVogZ
	IoFZq3AoEexCl8VQ0VAmGt7tDD/TkXCb8Haj5v4OcMRKqyC4zbmfuA0Cc4HqZwWyi/JHCRA+SSb
	TfStfNAYg4EFlsRNZVogIScJuN2R7lnaclUiiz+nLt9GhPeXMqbEoIWG9dEBLTKuDOVa8k7uA4i
	g8XBpWCtZgfaXdE+fv/8dB5o0P75DA5qKF8aN12x6F2gsfl6KXUCR5vmiehQK2DMPQ49oLsC4bC
	d+gIcRBk8D8y5j57dLjBxSkU1Rj0Fb6RsfjQkOUC7EfuECKlfjkYHKLXKlZqO4aDsqK3IvIqhV5
	iYH27ITdEWIIVNpfZ22Vgh1VhTksRsYm0VkPLvt3z31Gzi8cYd+kvV5PTK8azLoAt8wV1vijPeG
	Ht20jMLddxxlRWqcIwkPLU3jR/bgyRkD7WXKV5OKLAtrWeyv/fK2BVn/kggd8c8bEaFw==
X-Received: by 2002:a05:6402:528e:b0:69c:7406:9492 with SMTP id 4fb4d7f45d1cf-69e652e1111mr6897698a12.39.1784683434224;
        Tue, 21 Jul 2026 18:23:54 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-7364-df4e-3b35-2094.fixed6.kpn.net. [2a02:a463:a071:0:7364:df4e:3b35:2094])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69f34ba67f0sm321569a12.12.2026.07.21.18.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 18:23:53 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH v2] selftests/damon/sysfs.py: clean up sh processes used for obsolete_target test
Date: Wed, 22 Jul 2026 03:23:49 +0200
Message-ID: <20260722012349.9738-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721190404.135937-1-harimishal1@gmail.com>
References: <20260721190404.135937-1-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The obsolete_target test spawns three sh processes and uses their pids
as DAMON monitoring targets.  These processes are never terminated or
waited on, so they are left running (or become zombies) as orphaned
children after the test program exits.

Terminate each process and communicate() with it after the targets are
no longer needed, so it exits and gets reaped instead of being leaked.

Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
v2: Terminate each sh process directly instead of giving it its own
    stdin pipe to close, dropping the stdin=PIPE changes and shrinking
    the diff.

 tools/testing/selftests/damon/sysfs.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index aa03a1187489..bdb37eb1d26f 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -356,5 +356,9 @@ def main():
     assert_ctxs_committed(kdamonds)
     kdamonds.stop()
 
+    for proc in (proc1, proc2, proc3):
+        proc.terminate()
+        proc.communicate()
+
 if __name__ == '__main__':
     main()
-- 
2.43.0

