Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF454D1784
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790622799; cv=none; b=rEmFjk0NH9pX+5wg/Z8c9TYIR7X3AWJnfk3hQz6jRo3OWMKWQIWpGJv+09bXVRRrnpM+g2UeR0jFgePmXAadlWDJzZ6Omn6oOL5yEYHe5LA6oA+KOZgEVrWuHFVbAVz2PyMHS95M0yGWp6SwPPu+D9myq+vGC7Topl8NaI2YwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790622799; c=relaxed/simple;
	bh=k03DKg/grzODbN+PZ+I8vvS31QbX3ZyO6iLOqOxiZRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNtxyhQZZQoo3Vn/kDPgOTvcMbM3V4sNSnG2e/uTdap+S5IObgxEpOVUZSvnUM79xIfD9HsplP/UjkUIGLygyd0H8v7NCYe5pXjbDh3n7vCbg36RU2pa4NTNagrGP+9+GpbQYMWJSK/uKajCBK5cXiBmXvj7/3z2rbHRBqhGx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHHrqyFe; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHHrqyFe"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4c3304833so1248090a12.3
        for <damon@lists.linux.dev>; Mon, 28 Sep 2026 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790622797; x=1791227597; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pkU51f+1UpMIy8iBx8lVNiJZoAcmMG7LyZjfQO6BzzE=;
        b=cHHrqyFejSJqQ404nEdT4jbEwrU9bTaxSNEwpIW11nsAV8gsb89IXerVGweShyIzab
         +2mI7MH0rJMSKX64R2GOVhLvh0JNkibpwpWxwOFVVEpPhmQovX+2+4Cf9HPnd42uAkul
         3QU/T43+czSxR3FPwZQPlAFNbkCF/2WCaoZIjemyHCXTKSO47z83MrCCIrTLmuWbS34I
         FuZjYUhlZ4ZtmJ4S2IUmkbX9pG9foQ/sLVPN1wErFbStW+wfFRIzKu/ihNo8kixuH6Vi
         UOvKQcS0Ifuv/iAFzDXon7h0NLG/lZvEQtTHX1fKqIzmS7tozLQyg5Fqzf1M+gIfS73b
         ljyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790622797; x=1791227597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pkU51f+1UpMIy8iBx8lVNiJZoAcmMG7LyZjfQO6BzzE=;
        b=jj57z7wNuQaIZDjc51rI4Wvf/xsLUmIhPsP4qx4hs+XdD3jaIw4fNmQsgrsJnJZjpx
         Mrt+5NHSILkRXvI/Mlg+sNXhLX6m/ab9Ab8ARyRQRUWPMAx3GhaOrwrFyMv2G1xnxSkC
         ugSOis/tMhHBnP/3qpkgOGzZtw23uP/fB0ko3TwQyeqk9tDxiBZ6d3Gj2vd1Ds5t14Im
         Y/+0hfw80mQPoi6EXABKUbqhbTG3j3vFxYBugD24KMVoX5HgkU5gCmVjqRrYCxwkNDL2
         mFB/Iv2VqLe7jxOIkqeCvncNKvk/l1wueqcmXV9F3E0eEVCwFoRTZq4l/BmZ21lc8iOM
         OO9A==
X-Gm-Message-State: AFq9FYJp30rLjSY9L87J2mskakFzu0vWWp1tMadw7R8DaCZ/VZzIKWtn
	qhVte5OPnJNuOzjvG/WZAx4Uqc/modrZt0Xj7ZRhG4sfVyYgq3oVNxoR
X-Gm-Gg: AYBFou3tyzlonITTZQbK28L8TISAokPVkqFrFtF3W4TPR8kTc3SK+fYIk+cUoWUqKAK
	JhLz/3qLXRwOMD3esm3wokVUBDfB6zfdTbkiBKjzdTlJhM2w032oYNflJ6k8oVDumkarBo3Aix8
	nBk5w6nAZkEdYSzQ/EwQ6ut4QU+nEIIASJZiJpzivu7hsDqCJ57tHAOyS5XhwJUheshIR2TIzp/
	yeG1fi01JD6br5mJK91fr7zC55BliT7PGsZxQyux+25gKk3eObFCaHs3dxO6cj/swkFR+iwgfVw
	WsPx8L4C6g1SdqaVWmnIG7loDjHlBd7cFMgInwNJJbA8zofyQ19ay7PRWZ+oSBtTF8bIecwlVRS
	qpPGlpvKkYhj/4kKF6/DbTD75HyNXWHwqKzylcVVr1Li0hGaLDV0cAfIyiBo8v9uyxzGpUQFVbt
	qeq2xNly3b5Xk46c3K+y+07EDt84NfYvflpcqdmW2Tde9L2WKBXqnYj6xuADly2lWprw1Ti9Q7
X-Received: by 2002:a17:90b:4d81:b0:3a0:b50d:50ea with SMTP id 98e67ed59e1d1-3a0b50d527emr9363041a91.28.1790622797440;
        Mon, 28 Sep 2026 12:13:17 -0700 (PDT)
Received: from celestia ([2402:1980:867:387a:70b:38f1:a1dd:9303])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78794f224sm5177965a12.25.2026.09.28.12.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 12:13:16 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC] mm/damon/damo: saving damon sysfs configuration
Date: Tue, 29 Sep 2026 03:13:06 +0800
Message-ID: <20260928191332.138511-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ and Community,

I've noticed that damo [1] doesn't seem to have a feature for saving
DAMON SYSFS configuration.  I tried 'damo args damon', but it doesn't
save the DAMOS schemes information.  'damo report damon --json' provides
more detailed information, but its output cannot be read by 'damo start
--kdamonds'.

I'd like to know if there is currently any way in damo to save the DAMON
SYSFS configuration that can be correctly read by 'damo start
--kdamonds'.  If not, would it be worth adding one?

[1] https://github.com/damonitor/damo

Best regards,
Rui Yan
